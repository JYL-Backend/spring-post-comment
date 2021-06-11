<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@include file='../includes/header.jsp' %>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board List Page
                            <button id="regBtn" type="button" class="btn btn-xs pull-right">
                            	Register new Board
                            </button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        
                        	<!-- 목록 테이블 -->
                            <table class="table table-striped table-bordered table-hover">
                            	<thead>
                            		<tr>
                            			<th>#번호</th>
                            			<th>제목</th>
                            			<th>작성자</th>
                            			<th>작성일</th>
                            			<th>수정일</th>
                            		</tr>
                            	</thead>
                            	<c:forEach items="${list}" var="board">
                            		<tr>
                            			<td><c:out value="${board.bno}"/></td>
                            			<td>
                            				<a class='move' href="${board.bno}">
                            					<c:out value="${board.title}"/>
                            					<b>[<c:out value="${board.replyCnt}"/>]</b>
                            				</a>
                            			</td>
                            			<td><c:out value="${board.writer}"/></td>
                            			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                            			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                            		</tr>
                            	</c:forEach>
                            </table>
                            <!-- /목록 테이블 -->
                            <!-- 검색 조건 폼 -->
                            <div class='row'>
                            	<div class='col-lg-12'>
                            		<form id='searchForm' action='/board/list' method='get'>
                            			<select name='type'>
                            				<option value="" <c:out value="${pageMaker.criteria.type == null ? 'selected' : ''}"/>>
                            				--</option>
                            				<option value="T" <c:out value="${pageMaker.criteria.type eq 'T' ? 'selected' : ''}"/>>
                            				제목</option>
                            				<option value="C" <c:out value="${pageMaker.criteria.type eq 'C' ? 'selected' : ''}"/>>
                            				내용</option>
                            				<option value="W" <c:out value="${pageMaker.criteria.type eq 'W' ? 'selected' : ''}"/>>
                            				작성자</option>
                            				<option value="TC" <c:out value="${pageMaker.criteria.type eq 'TC' ? 'selected' : ''}"/>>
                            				제목 or 내용</option>
                            				<option value="TW" <c:out value="${pageMaker.criteria.type eq 'TW' ? 'selected' : ''}"/>>
                            				제목 or 작성자</option>
                            				<option value="TWC"<c:out value="${pageMaker.criteria.type eq 'TWC' ? 'selected' : ''}"/>>
                            				제목 or 내용 or 작성자</option>
                            			</select>
                            			<input type='text' name='keyword'
                            				 value = '<c:out value="${pageMaker.criteria.keyword}"/>'/>
                            			<input type='hidden' name='pageNum' value='${pageMaker.criteria.pageNum}'/>
                            			<input type='hidden' name='amount' value='${pageMaker.criteria.amount}'/>
                            			<button class='btn btn-default'>Search</button>
                            		</form>
                            	</div>
                            </div>
                            <!-- /검색 조건 폼 -->
                            <!-- 페이징 -->
                            <div class='pull-right'>
                            	<ul class='pagination'>
                            		<!-- prev 존재 -->
                            		<c:if test="${pageMaker.prev}">
                            			<li class="paginate_button previous">
                            				<a href="${pageMaker.startPage - 1}">Previous</a>
                            			</li>
                            		</c:if>
                            		<!-- 페이지 번호 -->
                            		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }">
                            			<li class="paginate_button ${pageMaker.criteria.pageNum == num ? "active" : "" }">
                            				<a href="${num}"> ${num}</a>
                            			</li>
                            		</c:forEach>
                            		<!-- next 존재 -->
                            		<c:if test="${pageMaker.next}">
                            			<li class="paginate_button next">
                            				<a href="${pageMaker.endPage+1}">Next</a>
                            			</li>
                            		</c:if>
                            	</ul>
                            </div>
                            <!-- /페이징 -->
                            <!-- 페이짐 hidden폼 -->
                            <form id='actionForm' action='/board/list' method='get'>
                            	<input type='hidden' name='pageNum' value='${pageMaker.criteria.pageNum}'>
                            	<input type='hidden' name='amount' value='${pageMaker.criteria.amount}'>
                           			<input type='hidden' name='type' value='${pageMaker.criteria.type}'/>
                           			<input type='hidden' name='keyword' value='${pageMaker.criteria.keyword}'/>
                            </form>
                            <!-- /페이짐 hidden폼 -->
                            
                          	<!-- 모달창 -->
                          	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            처리가 완료되었습니다.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                          	<!-- /모달창 -->
                          	
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->

<script type="text/javascript">
	$(document).ready(function(){
		
		/* 게시글 등록 확인 */
		var result = '<c:out value="${result}"/>'
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		/* 새 글 작성 버튼 */
		$('#regBtn').on('click', function(){
			self.location = '/board/register';
		});
		
		/* 페이징 폼 처리 */
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr('href'));
			actionForm.submit();
		});
		
		/* 게시글 클릭 처리 */
		$(".move").on('click', function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr('href')+"'>");
			actionForm.attr('action', '/board/get');
			actionForm.submit();
		});
		
		/* 검색버튼 이벤트 처리 */
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요.");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요.");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
			
		});
	});


	function checkModal(result) {
		if(result==='' || history.state){return;}
		
		if(parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록처리되었습니다.");
		}
		$("#myModal").modal("show");
	}
	
</script>
<%@include file='../includes/footer.jsp' %>