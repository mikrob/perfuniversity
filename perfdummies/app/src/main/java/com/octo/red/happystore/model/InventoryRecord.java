package com.octo.red.happystore.model;

import java.io.Serializable;

public class InventoryRecord  implements Serializable {
	private String categoryLabel;
	private Integer categoryId;
	private String productLabel;
	private Integer quantity;

	public String getCategoryLabel() {
		return categoryLabel;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public String getProductLabel() {
		return productLabel;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public InventoryRecord(String categoryLabel, Integer categoryId, String productLabel, Integer quantity) {
		super();
		this.categoryLabel = categoryLabel;
		this.categoryId = categoryId;
		this.productLabel = productLabel;
		this.quantity = quantity;
	}
}
