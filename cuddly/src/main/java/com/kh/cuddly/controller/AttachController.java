package com.kh.cuddly.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ReviewDao;
import com.kh.cuddly.dto.AttachDto;

@Controller
@RequestMapping("cuddly/image")
public class AttachController {

	@Autowired
	ProductDao productDao;
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	CreatorDao creatorDao;

	@ResponseBody
	@RequestMapping("/product/main") // 상품 메인 이미지
	public ResponseEntity<ByteArrayResource> productMainImage(@RequestParam int productNo) throws IOException {

		AttachDto attachDto = productDao.findProductMainImage(productNo);
		if (attachDto == null) {
			return ResponseEntity.notFound().build();
		}

		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize()).header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition
						.attachment().filename(attachDto.getAttachName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}
	
	@ResponseBody
	@RequestMapping("/product/detail") // 상품 상세 이미지
	public ResponseEntity<ByteArrayResource> productDetailImage(@RequestParam int productNo) throws IOException {

		AttachDto attachDto = productDao.findProductDetailImage(productNo);
		if (attachDto == null) {
			return ResponseEntity.notFound().build();
		}

		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize()).header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition
						.attachment().filename(attachDto.getAttachName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}
	
	@ResponseBody
	@RequestMapping("/review/image") // 리뷰이미지
	public ResponseEntity<ByteArrayResource> reviewImage(@RequestParam int reviewNo) throws IOException {

		AttachDto attachDto = reviewDao.findImage(reviewNo);
		if (attachDto == null) {
			return ResponseEntity.notFound().build();
		}

		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize()).header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition
						.attachment().filename(attachDto.getAttachName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}
	
	@ResponseBody
	@RequestMapping("/creator") // 크리에이터이미지
	public ResponseEntity<ByteArrayResource> creatorImage(@RequestParam int creatorNo) throws IOException {

		AttachDto attachDto = creatorDao.findCreatorImage(creatorNo);
		if (attachDto == null) {
			return ResponseEntity.notFound().build();
		}

		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize()).header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition
						.attachment().filename(attachDto.getAttachName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}
	
}
