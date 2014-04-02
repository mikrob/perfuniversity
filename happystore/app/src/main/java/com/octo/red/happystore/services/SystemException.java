package com.octo.red.happystore.services;

@SuppressWarnings("serial") //Better let runtime do
public class SystemException extends RuntimeException {
	public SystemException(String message) {
		super(message);
	}
}
