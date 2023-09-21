package com.kh.cuddly.error;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class NoResultException extends RuntimeException {
	public NoResultException(String message) {
		super(message);
	}
}
