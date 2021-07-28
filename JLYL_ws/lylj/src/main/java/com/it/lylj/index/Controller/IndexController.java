package com.it.lylj.index.Controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.it.lylj.attend.model.AttendService;
import com.it.lylj.attend.model.AttendVO;
import com.it.lylj.attendDay.model.AttendDayService;
import com.it.lylj.attendDay.model.AttendDayVO;
import com.it.lylj.booking.model.BookingService;
import com.it.lylj.booking.model.BookingVO;
import com.it.lylj.department.model.DepartmentService;
import com.it.lylj.department.model.DepartmentVO;
import com.it.lylj.electronic.model.ElectronicService;
import com.it.lylj.electronic.model.ElectronicVo;
import com.it.lylj.emp.model.EmpService;
import com.it.lylj.emp.model.EmpVO;
import com.it.lylj.index.model.OriVo;
import com.it.lylj.schedule.model.ScheduleService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class IndexController {
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	private final EmpService empService;
	private final DepartmentService departmentService;
	private final ElectronicService eleService;
	private final BookingService bookingService;
	private final ScheduleService scheduleService;
	private final AttendDayService attendDayService;
	
	@RequestMapping("/inc/organizationChart")
	public void organizationChart() {
		logger.info("메인 화면 보여주기");

	}

	@RequestMapping("/index")
	public void test(HttpSession session, Model model) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		logger.info("메인페이지");
		int empNo = Integer.parseInt((String)session.getAttribute("empNo"));
		
		List<ElectronicVo> elist = eleService.selectUpdateToday(empNo);
		List<BookingVO> bookingList2 = bookingService.selectAllBookingViewByEmpNo(empNo);
		List<BookingVO> bookingList = new ArrayList<BookingVO>();
		Date startDate;
		Date endDate;
		for(int i=0; i<bookingList2.size(); i++) {
			try {
				startDate = sdf.parse(bookingList2.get(i).getBookingStart());
				endDate = sdf.parse(bookingList2.get(i).getBookingEnd());
				if(startDate.getTime()<now.getTime() && now.getTime()<endDate.getTime()) {
					bookingList.add(bookingList2.get(i));
				}
			} catch (ParseException e) {
			}
		}
		Date today = new Date();
		today.setHours(0);
		today.setMinutes(0);
		today.setSeconds(0);
		logger.info("strToday ={}",today);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("nowDate", today);
		int todayScheduleCnt= scheduleService.selectCntScheduleByToday(map);
		AttendDayVO atdVO = new AttendDayVO();
		atdVO.setEmpNo(empNo);
		atdVO.setAttendanceDayRegdate(today);
		AttendDayVO attendDayVO = attendDayService.selectAttendDayByRegdate(atdVO);
		
		
		
		logger.info("elist={}", elist);
		
		model.addAttribute("elist", elist);
		model.addAttribute("empNo", empNo);
		model.addAttribute("bookingList", bookingList);
		model.addAttribute("todayScheduleCnt", todayScheduleCnt);
		model.addAttribute("attendDayVO", attendDayVO);
	}
	
	@RequestMapping("/admin")
	public String admin(Model model) {
		logger.info("관리자페이지");
		model.addAttribute("navNo", 8);
		return "adminMain";
	}

	@ResponseBody
	@RequestMapping("/inc/list")
	public List<OriVo> selectOri() {
		logger.info("트리뷰 보여주기");

		List<OriVo> olist = new ArrayList<>();
		List<EmpVO> elist = empService.selectAllEmpForEle(); //사용자
		List<DepartmentVO> dlist = departmentService.selectAllDepartment(); //부서

		for (int i = 0; i < elist.size(); i++) {

			EmpVO empVo = elist.get(i);
			OriVo orivo = new OriVo();
			int depNo = empVo.getDepartmentNo();
			if (depNo == 0) {
				orivo.setParent("#");
			} else {
				orivo.setParent(Integer.toString(depNo));
			}
			orivo.setId(Integer.toString(empVo.getEmpNo()));
			orivo.setText(empVo.getEmpName());
			orivo.setUserEmail(empVo.getEmpEmail());
			orivo.setUserTel(empVo.getEmpTel());
			orivo.setUserImg(empVo.getEmpPhoto());
			olist.add(orivo);
		}

		for (int i = 0; i < dlist.size(); i++) {

			DepartmentVO departVo = dlist.get(i);
			OriVo orivo = new OriVo();
			orivo.setId(Integer.toString(departVo.getDepartmentNo()));
			orivo.setText(departVo.getDepartmentName());
			orivo.setParent("#");

			olist.add(orivo);
		}
		
		logger.info("트리뷰 결과 olist={}", olist);
		
		return olist;

	}
	
	@ResponseBody
	@RequestMapping("/inc/getInfomation")
	public EmpVO getInfomation(@RequestParam int EmpNo) {
		logger.info("aside modal 에뿌려줄  유저 정보 가져오기 파라미터 EmpNo={} ", EmpNo);
		EmpVO empVo = empService.selectByEmpNo(EmpNo);
		logger.info("empVo={}", empVo);
		return empVo;
	}
	
	
	@RequestMapping("/mainWeather")
	public void weather() {
		logger.info("날씨보여주기");
		
	}

}
