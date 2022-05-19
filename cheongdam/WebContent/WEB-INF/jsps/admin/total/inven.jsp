<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<script type="text/javascript" src="/assets/admin/js/zjsp/total/z_inven.js"> </script>
	
	<div class="con_tit">통계 &gt; 약재입고장</div>
	
	<div class="conBox">
		<ul>
			<li style="float: left;width: 50%;">
				<div style="padding: 10px 25px;">
					<div class="inputArea disB">
						<select id="search_all_title">
							<option value="yak_name">약재명</option>
						</select>
						<input type="text" id="search_all_value" onkeydown="javascript: if (event.keyCode == 13) {search_all();}" />
						<a href="#" id="all_searchBtn" class="btn01">검색</a>
					</div>					
					<table id="allGrid"></table>
					<div id="allGridControl"></div>
					
				</div>
			</li>
			<li style="float: left;width: 50%;">
				<div style="padding: 10px 25px;">
					<div class="inputArea disB" style="text-align: right;">
						<a href="#" id="delBtn" class="btn03">선택삭제</a>
					</div>
					<table id="invenGrid"></table>
					<div id="invenGridControl"></div>
					
					
					<div class="input_form" style="display: none;">
						<form action="#" id="addFrm" method="post">
							<table class="tbl" style="margin-top:40px;">
								<colgroup>
									<col width="35%" />
									<col width="25%" />
									<col width="25%" />
									<col width="15%" />
								</colgroup>
								<thead>
									<tr style="text-align:center;">
										<th>입고할 약재명</th>
										<th>입고일</th>
										<th>입고수량(g)</th>
										<th>기능</th>
									</tr>
								</thead>
								
								<tr>
									<td>
										<span id="a_yak_name" style="color: blue;font-weight: 700;">선택된 약재가 없습니다1.</span>
										<input type="hidden" name="a_yak_seqno"  id="a_yak_seqno"  />
										<input type="hidden" name="a_yak_code" id="a_yak_code"  />
										<input type="hidden" name="a_a_id" 	  id="a_a_id"  value="${adminInfo.a_id}" />
									</td>
									<td style="text-align:center;"><input type="text" name="a_add_date" id="a_add_date" class="date" style="width: 80px;" readonly="readonly" /> 일</td>
									<td style="text-align:center;"><input type="text" name="a_ea" id="a_ea" style="width: 50px;text-align: right;" value="0" onkeydown="javascript: if (event.keyCode == 13) {onAdd();}"  /> g</td>
									<td  style="text-align:center;"><a href="#" id="yakAddBtn" class="btn01">추가하기</a></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</li>
		</ul>
	
		
	</div>

</html>
