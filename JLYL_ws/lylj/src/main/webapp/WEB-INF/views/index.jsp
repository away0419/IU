<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="inc/top.jsp"%>

<link href='<c:url value="/resources/css/main.css"/>' rel="stylesheet" />
<script src='<c:url value="/resources/js/main.js"/>'></script>
<script src='<c:url value="/resources/js/scheduleMain.js"/>'></script>
<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- Page Heading -->
	<h1 class="h3 mb-4 text-gray-800">어서오세요 ${empName} 님</h1>

	<div class="row">

		<div class="col-lg-6">

			<!-- Circle Buttons -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
				</div>
				<div class="card-body">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover " id="dataTable"
								width="100%" cellspacing="0">
								<colgroup>
									<col style="width: 60%;" />
									<col style="width: 20%;" />
									<col style="width: 20%;" />
								</colgroup>
								<thead class="table-success">
									<tr>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th><a href="#">월요일 식단표</a></th>
										<th>김부장</th>
										<th>2021-07-08</th>
									</tr>
								</tbody>
								<tbody>
									<tr>
										<th><a href="#">금요일 식단표</a></th>
										<th>김부장</th>
										<th>2021-07-08</th>
									</tr>
								</tbody>
								<tbody>
									<tr>
										<th><a href="#">수요일 식단표</a></th>
										<th>김부장</th>
										<th>2021-07-08</th>
									</tr>
								</tbody>
								<tbody>
									<tr>
										<th><a href="#">내일 식단표</a></th>
										<th>김부장</th>
										<th>2021-07-08</th>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<!-- Brand Buttons -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">오늘 받은 메일</h6>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-hover">
							<tbody>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: 60%;" />
								<col style="width: 20%;" />
							</colgroup>
							<thead class="table-info">
								<tr>
									<th scope="col">보낸 사람</th>
									<th scope="col">제목</th>
									<th scope="col">보낸 날짜</th>
								</tr>
							</thead>
							<tr>
								<td class="name">Larry Gardner</td>
								<td class="subject"><a href="#">Lorem ipsum dolor sit
										amet, consectetur adipisicing elit, sed </a></td>
								<td class="time">08:30 PM</td>
							</tr>
							<tr>
								<td class="name">Larry Gardner</td>
								<td class="subject"><a href="#">Lorem ipsum dolor sit
										amet, consectetur adipisicing elit, sed </a></td>
								<td class="time">08:30 PM</td>
							</tr>
							<tr>
								<td class="name">Larry Gardner</td>
								<td class="subject"><a href="#">Lorem ipsum dolor sit
										amet, consectetur adipisicing elit, sed </a></td>
								<td class="time">08:30 PM</td>
							</tr>
							<tr>
								<td class="name">Larry Gardner</td>
								<td class="subject"><a href="#">Lorem ipsum dolor sit
										amet, consectetur adipisicing elit, sed </a></td>
								<td class="time">08:30 PM</td>
							</tr>

							</tbody>

						</table>
					</div>
				</div>
			</div>
			
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">최근 받은 기안서</h6>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-hover">
							<tbody>
							<colgroup>
								<col style="width: 60%;" />
								<col style="width: 40%;" />
							</colgroup>
							<thead class="table-info">
								<tr>
									<th scope="col">제목</th>
									<th scope="col">기안자 번호</th>
								</tr>
							</thead>
							<c:if test="${empty elist }">
								<tr>
									<td class="name" colspan="2">최근 받은 기안서가 없습니다</td>
								</tr>
							</c:if>
							<c:if test="${!empty elist}">
								<c:forEach var="ele" items="${elist }">
									<tr>
										<td class="subject"><a href="<c:url value = '/electronic/electronicDetail?ElectronicNo='/>${ele.electronicNo }&no=1">${ele.electronicTitle } </a></td>
										<td class="name">${ele.empNo }</td>
									</tr>
								</c:forEach>
							</c:if>
							</tbody>

						</table>
					</div>
				</div>
			</div>

		</div>

		<div class="col-lg-6">

			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">오늘의 예약</h6>
				</div>
				<div class="card-body">
					<table class="table table-hover">
						<colgroup>
							<col style="width: 60%;" />
							<col style="width: 20%;" />
							<col style="width: 20%;" />
						</colgroup>
						<thead class="table-primary">
							<tr>
								<th scope="col">예약 내용</th>
								<th scope="col">자산명</th>
								<th scope="col">예약한 날짜</th>
							</tr>
						</thead>
						<tbody id="bookingTBody">
							<c:if test="${bookingList.size() !=0 }">
								<c:set var="checkNum" value="0"/>
								<c:forEach var="i" begin="0" end="2">
									<c:if test="${bookingList.size()>i}">
										<tr>
											<td>${bookingList.get(i).bookingContent}</td>
											<td>${bookingList.get(i).bookingTargetName}</td>
											<td><fmt:formatDate value="${bookingList.get(i).bookingCurrent}" pattern="yyyy-MM-dd"/> </td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test="${bookingList.size() ==0 }">
								<tr>
									<td colspan="3" align="center">금일 예약 내역이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>

				</div>
			</div>
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">오늘의 일정</h6>
				</div>
				<div class="card-body">
					<div id='calendar'></div>
				</div>
			</div>
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">지역별 날씨</h6>
				</div>
				<div class="card-body">
				<%@ include file="mainWeather.jsp"%>
				</div>
			</div>

		</div>

	</div>

</div>
<!-- /.container-fluid -->


<%@ include file="inc/bottom.jsp"%>
