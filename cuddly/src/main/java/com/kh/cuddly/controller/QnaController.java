package com.kh.cuddly.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.QnaDto;
import com.kh.cuddly.dto.ReviewDto;

@Controller
@RequestMapping("/cuddly/qna")
public class QnaController {
	
	@Autowired
	QnaDao qnaDao;
	
	@GetMapping("/write")
	public String write() {
		
		return "/WEB-INF/views/qna/insert.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute QnaDto qnaDto,
			HttpSession session) {
		
		int qnaNo = qnaDao.sequence();
		
		qnaDto.setQnaNo(qnaNo);
		
		qnaDao.insert(qnaDto);
		
		return "redirect:/cuddly/qna/write";

	}
	
	@GetMapping("/change")
	public String edit(HttpSession session, Model model, int qnaNo) {
		
		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
		
		model.addAttribute("qnaDto",qnaDto);
		
		return "/WEB-INF/views/qna/edit.jsp";
		
	}
	
	@PostMapping("/change")
	public String edit(@ModelAttribute QnaDto qnaDto, int qnaNo) {
		
		qnaDto.setQnaNo(qnaNo);
		
		qnaDao.update(qnaDto);
		
		return "redirect:/cuddly/qna/change?qnaNo="+qnaNo;
		
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<QnaDto> list = qnaDao.selectList();
		
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/qna/list.jsp";
		
	}
	
	@ResponseBody
	@RequestMapping("/image")
	public ResponseEntity<ByteArrayResource> 
							image(@RequestParam int productNo) throws IOException {
		//[1] 포켓몬 번호로 파일 번호를 찾아야 한다
		//[2] 파일 번호로 파일 정보를 불러와야 한다
		//[3] 실제 파일을 불러와야 한다
		//[4] 앞에서 불러온 모든 정보로 ResponseEntity를 생성한다
		//[5] 사용자한테 준다
		
		//1,2
		AttachDto attachDto = qnaDao.findImage(productNo);
		
		if(attachDto == null) {
//			throw new NoTargetException("파일 없음");
			//내가 만든 예외로 통합
			
			return ResponseEntity.notFound().build();
			//404로 반환
			
		}
		
		//3
		String home = System.getProperty("user.home");
		File dir = new File(home,"upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);// 실제파일정보 불러오기
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//4,5 - header(정보), body(내용)
		return ResponseEntity.ok()
//				.header("Content-Encoding","UTF-8")
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
//				.header("Content-Length",String.valueOf(attachDto.getAttachSize()))
				.contentLength(attachDto.getAttachSize())
//				.header("Content-Type",attachDto.getAttachType())//저장된 유형
				.header(HttpHeaders.CONTENT_TYPE,attachDto.getAttachType())
//				.header("Content-Type","application/octet-stream")//무조건 다운로드
//				.contentType(MediaType.APPLICATION_OCTET_STREAM)
//				.header("Content-Disposition","attachment; filename="+attachDto.getAttachName())
				.header(HttpHeaders.CONTENT_DISPOSITION,
					ContentDisposition.attachment().filename(attachDto.getAttachName(),StandardCharsets.UTF_8)
					.build().toString()
						)
				
			.body(resource);	
	}
	
	
	
	

}
