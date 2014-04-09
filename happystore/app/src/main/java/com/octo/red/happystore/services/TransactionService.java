package com.octo.red.happystore.services;

import com.codahale.metrics.annotation.Timed;
import com.octo.red.happystore.dao.*;
import com.octo.red.happystore.model.*;
import com.octo.red.happystore.performance.CacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NonUniqueResultException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

@Service
public class TransactionService {
	private static final String EUR = "EUR";

    @Autowired
    CacheManager cacheManager;

	@Autowired
	VatRepository vatRepository;
	@Autowired
	ProductRepository productRepository;
	@Autowired
	SaleTransactionRepository saleTransactionRepository;
	@Autowired
	SaleOperationRepository saleOperationRepository;
	@Autowired
	StockRepository stockRepository;
	@Autowired
	CurrencyConverter currencyConverter;

    @Timed
    @Transactional
    public SaleOperation buy(String countryCode, long productId, long storeId, Long txId) {
		if(countryCode == null || countryCode.length()== 0) {
			throw new IllegalArgumentException("countryCode must not be null");
		}
		
		Product p = findProductById(productId);
		VAT v = getVatByCountryCodeAndProductId(countryCode, productId);
		
		if(p == null || v == null) {
			throw new SystemException(String.format("Product %s or VAT %s not found, check database", productId, countryCode));
		}
		
		//Compute Price in Euro
		BigDecimal eurPrice = v.getVatRate().add(BigDecimal.ONE).multiply(p.getSellPrice());
		//Price in the catalog are in EUR, convert according to the country
		String operationCurrency = currencyConverter.getCurrency(countryCode);
		BigDecimal price = currencyConverter.convert(eurPrice, EUR, operationCurrency);
		//Update corresponding transaction
        SaleTransaction saleTransaction;
        if (txId != null) {
            saleTransaction = saleTransactionRepository.findOne(txId);
            if(saleTransaction == null) {
				throw new SystemException("No transaction found for id " + txId);
			}
		} else {
			saleTransaction = new SaleTransaction();
			saleTransaction.setCancellation(null);
			saleTransaction.setCancellationClerkName("cancellationClerkName");
			saleTransaction.setCancellationClerkNumber(1);
			saleTransaction.setCancellationTicketNumber(1);
			saleTransaction.setCancellationType(1);
			saleTransaction.setChangeAmount("changeAmount");
			saleTransaction.setClerkName("clerkName");
			saleTransaction.setClerkNumber(1);
			saleTransaction.setClientName("clientName");
			saleTransaction.setClientNumber(1);
			saleTransaction.setDiscountAmount("discountAmount");
			saleTransaction.setDiscountRate(BigDecimal.ZERO);
			saleTransaction.setGroupId(1);
			saleTransaction.setStartDate(new Date());
			saleTransaction.setTicketNumber(1);
			saleTransaction.setTotalAmount(BigDecimal.ZERO);
			saleTransaction.setTransactionKey("transactionKey");
		}
		
		saleTransaction.setTotalAmount(saleTransaction.getTotalAmount().add(eurPrice));
		saleTransactionRepository.save(saleTransaction);
		
		//Register the SaleOperation and link it to the transaction
		SaleOperation saleOperation = new SaleOperation();
		saleOperation.setAmount(price);
		saleOperation.setCurrency(operationCurrency);
		Calendar annulationDateCal = Calendar.getInstance();
		saleOperation.setAnnulation(annulationDateCal.getTime());
		saleOperation.setAnnulationCashierName("annulationCashierName");
		saleOperation.setAnnulationCashierNumber(1);
		saleOperation.setAnnulationType(1);
		saleOperation.setBossTransactionNumber("bossTransactionNumber");
		saleOperation.setBusinessCategory(1);
		saleOperation.setCashierName("cashierName");
		saleOperation.setCashierNumber(1);
		Calendar calendar = Calendar.getInstance();
		saleOperation.setDate(calendar.getTime());
		saleOperation.setDiscountAmount("discountAmount");
		saleOperation.setDiscountRate(BigDecimal.ONE);
		saleOperation.setGroupId(1);
		saleOperation.setIncreaseRate(1L);
		saleOperation.setIsBackToStock(false);
		saleOperation.setIsReturn(false);
		saleOperation.setIsScanned(false);
		saleOperation.setOnlineSaleStatus("onlineSaleStatus");
		saleOperation.setProductLabel("productLabel");
		saleOperation.setQuantity(1);
		saleOperation.setReloadCode("reloadCode");
		saleOperation.setSalesCode("salesCode");
		saleOperation.setSaleTransaction(null);
		saleOperation.setSpecialOperationTypeSalePrice(1);
		saleOperation.setSupplierProductReference("supplierProductReference");
		saleOperation.setSaleTransaction(saleTransaction);
		saleOperationRepository.save(saleOperation);
		
		//Update the stock of the corresponding store
        Stock stock;
        try {
            stock = stockRepository.findOneByStoreAndProductId(storeId, productId);
        } catch(NonUniqueResultException nonUniqueResultException) {
            throw new SystemException(String.format("Error looking for stock for storeId {0} and productId {1}", storeId, productId));
        }
		if(stock == null) {
			throw new SystemException(String.format("No stock found for storeId {0} and productId {1}", storeId, productId));
		}
		stock.setQuantity(stock.getQuantity() - saleOperation.getQuantity());
		return saleOperation;
		
	}

    @Timed
    public TotalVo computeTotal(long txId) {
		SaleTransaction saleTransaction = saleTransactionRepository.findOne(txId);
		if(saleTransaction == null) {
			throw new SystemException("No transaction found for id " + txId);
		}
		//Transaction amount is computed in Euros
		return new TotalVo(saleTransaction.getTotalAmount(), EUR);
	}

    @Timed
    private Product findProductById(long productId) {
        Product p = cacheManager.getFromCache("product", (Long) productId);
        if(p != null) {
            return p;
        }
        p = productRepository.findOne(productId);
        cacheManager.addToCache("product", productId, p);
        return p;
    }

    @Timed
    private VAT getVatByCountryCodeAndProductId(String countryCode, long productId) {
        String key = countryCode + '#' + productId;
        VAT v = cacheManager.getFromCache("vat", key);
        if(v != null) {
            return v;
        }
        v = vatRepository.findOneByCountryCodeAndProductId(countryCode.toUpperCase(), productId);

        cacheManager.addToCache("vat", key, v);
        return v;
    }
}
