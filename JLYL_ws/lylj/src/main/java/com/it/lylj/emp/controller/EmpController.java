package com.it.lylj.emp.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.lookup.VoidTypeBinding;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.it.lylj.common.ConstUtil;
import com.it.lylj.common.FileUploadUtil;
import com.it.lylj.common.PaginationInfo;
import com.it.lylj.common.SearchVO;
import com.it.lylj.department.model.DepartmentService;
import com.it.lylj.department.model.DepartmentVO;
import com.it.lylj.emp.model.EmpService;
import com.it.lylj.emp.model.EmpVO;
import com.it.lylj.position.model.PositionService;
import com.it.lylj.position.model.PositionVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/emp")
public class EmpController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmpController.class);
	private final PositionService positionService;
	private final DepartmentService departmentService;
	private final EmpService empService;
	private final FileUploadUtil fileUploadUtil;
	
	//사원등록페이지
	@GetMapping("/empWrite")
	public String empWrite(Model model) {
		//1
		logger.info("사원등록페이지");
		
		//2
		List<PositionVO> positionList = positionService.selectAllPosition();
		List<DepartmentVO> departmentList = departmentService.selectAllDepartment();
		logger.info("positionList={}, departmentList={}", positionList, departmentList);
		
		//3
		model.addAttribute("positionList", positionList);
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("navNo", 8);
		
		return "emp/empWrite";
		
	}
	
	//사원등록처리
	@PostMapping("/empWrite")
	public String empWrite_post(@ModelAttribute EmpVO vo, HttpServletRequest request, Model model) {
		//1
		logger.info("사원등록처리, 파라미터 vo={}",vo);
		
		//2
		//사진업로드
		String fileUrl ="";
		
		try {
			List<Map<String, Object>> list = fileUploadUtil.fileUpload(request, ConstUtil.UPLOAD_EMP_FLAG);
			
			for(int i=0; i<list.size();i++ ) {
				Map<String, Object> map = list.get(i);
				fileUrl = (String)map.get("fileName");
			}
			
			logger.info("파일 업로드 성공, fileUrl={}",fileUrl);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		vo.setEmpPhoto(fileUrl);
		
		//등록처리
		int cnt = empService.insertEmp(vo);
		logger.info("사원등록정보 vo={}",vo);
		logger.info("사원등록처리 성공여부, cnt={}",cnt);
		
		String msg ="등록실패", url="/emp/empWrite";
		if(cnt>0) {
			msg="등록성공";
			url="/emp/empList";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
	//비밀번호 체크
	@ResponseBody
	@RequestMapping("/pwdCheck")
	public boolean pwdCheck(@RequestParam String empPwd ) {
		logger.info("비밀번호 chk, empPwd={}", empPwd);
		
		boolean chkPwd = false;
		
		//최소 8자, 최소 하나의 문자 및 하나의 숫자 포함
		String validPwd = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";
		
		Pattern pt_symbol= Pattern.compile(validPwd);
		Matcher mt_symbol= pt_symbol.matcher(empPwd);
		
		if(mt_symbol.find()) {
			chkPwd=true;
		}
		
		return chkPwd;
	}

	//사원정보 디테일
	@GetMapping("/empInfo")
	public String empinfo(@RequestParam(defaultValue = "0")int empNo,  Model model) {
		//1
		logger.info("사원정보디테일 페이지, 파라미터 empNo={}",empNo);
		
		//vo 보내기
		EmpVO vo = empService.selectByEmpNo(empNo);
		logger.info("사원정보, 파라미터 vo={}",vo);
		//3
		//관리자 레벨일 경우 관리자 nav
		if(vo.getEmpAdminLev()==1||vo.getEmpAdminLev()==2) {
			model.addAttribute("navNo", 8);
		}
		
		model.addAttribute("vo", vo);

		return "emp/empInfo";
	}
	
	//사원정보수정 페이지보기
	@GetMapping("/empEdit")
	public String empEdit(@RequestParam(defaultValue = "0") int empNo, HttpSession session ,Model model) {
		logger.info("사원정보수정페이지, empNo={}", empNo);
		int adminLev = (int)session.getAttribute("empAdminLev");
		EmpVO empVo = empService.selectByEmpNo(empNo);
		logger.info("사원정보수정페이지, adminLev={}", adminLev);
		
		// 관리레벨이 1, 2이면 관리자정보로
		if(adminLev==1 || adminLev==2) {
			model.addAttribute("navNo", 8);
		}
		
		model.addAttribute("empVo", empVo);
		
		return "emp/empEdit";
	}
	
	//사원정보 수정처리
	@PostMapping("/empEdit")
	public String empEdit_post(@ModelAttribute EmpVO empVo, @RequestParam String mEmpNo
			, @RequestParam String mEmpPwd, HttpServletRequest request, @RequestParam String oldFileName, Model model) {
		logger.info("사원정보 수정처리, vo={}", empVo);
		
		int result = empService.loginProc(Integer.parseInt(mEmpNo), mEmpPwd);
		logger.info("정보확인,result={}",result);
			
		String msg="사원정보수정 실패", url="/emp/empEdit?empNo="+empVo.getEmpNo();
		if(result==EmpService.LOGIN_OK) {
			//파일 수정
			String fileUrl="";
			List<Map<String, Object>> list = null;
			try {
				list = fileUploadUtil.fileUpload(request, ConstUtil.UPLOAD_EMP_FLAG);
				
				for(int i=0; i<list.size();i++ ) {
					Map<String, Object> map = list.get(i);
					fileUrl = (String)map.get("fileName");
				}
				
				logger.info("파일 업로드 성공, fileUrl={}",fileUrl);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			empVo.setEmpPhoto(fileUrl);
			
			//수정처리
			int cnt = empService.updateEmp(empVo);
			logger.info("사원정보수정여부 cnt={}",cnt);
			if(cnt>0) {
				msg="사원정보가 수정되었습니다.";
				url="/emp/empInfo?empNo="+empVo.getEmpNo();
			}
			
		}else if(result==EmpService.PWD_DISAGREE) {
			msg="비밀번호가 일치하지 않습니다";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	//사원정보 리스트 보기
	@RequestMapping("/empList")
	public String empList(@ModelAttribute SearchVO searchVo , Model model) {
		logger.info("사원정보리스트 페이지");
		
		//2
		//
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());
		pagingInfo.setBlockSize(ConstUtil.EMP_BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(ConstUtil.EMP_RECORD_COUNT);
		
		//
		searchVo.setRecordCountPerPage(ConstUtil.EMP_RECORD_COUNT);
		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		logger.info("searchVo={}",searchVo);
		
		List<EmpVO> empList = empService.selectAllEmpList(searchVo);
		logger.info("사원목록조회, empList.size()={}",empList.size());
		
		int totalRecord = empService.selectTotalEmp(searchVo);
		logger.info("totalRecord={}",totalRecord);
		
		pagingInfo.setTotalRecord(totalRecord);
		
		model.addAttribute("navNo", 8);
		model.addAttribute("empList", empList);
		model.addAttribute("pagingInfo", pagingInfo);
		
		return "emp/empList";
		
	}

}



