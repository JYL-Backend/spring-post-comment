<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@include file='../includes/header.jsp' %>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <!----------------------- Content ----------------------->
                            <form role="form" action="/board/modify" method="post">
                            	<!-- 페이지번호 -->
                           		<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
                           		<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
                           		<input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
                           		<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
                           		<!-- 번호 -->
                            	<div class="form-group">
                            		<label>Bno</label> 
                            		<input class="form-control" name="bno" 
                            		value='<c:out value="${board.bno}"/>' readonly='readonly'>
                            	</div>
                            	<!-- 제목 -->
                            	<div class="form-group">
                            		<label>Title</label> 
                            		<input class="form-control" name="title" 
                            		value='<c:out value="${board.title}"/>'>
                            	</div>
                            	<!-- 내용 -->
                            	<div class="form-group">
                            		<label>Text Area</label> 
                            		<textarea class="form-control" rows='3' name="content">
                            		<c:out value="${board.content}"/>
                            		</textarea>  
                            	</div>
                            	<!-- 작성자 -->
                            	<div class="form-group">
                            		<label>Title</label> 
                            		<input class="form-control" name="writer" 
                            		value='<c:out value="${board.writer}"/>'>
                            	</div>
                            	<!-- 버튼 -->
                            	<button type='submit' data-oper='modify' class='btn btn-default'>
                            		Modify
                            	</button>
                            	<button type='submit' data-oper='remove' class='btn btn-danger'>
                            		Remove
                            	</button>
                            	<button type='submit' data-oper='list' class='btn btn-info'>
                            		List
                            	</button>
                            	>
                            </form>
                            <!----------------------- Content ----------------------->
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
		var formObj = $('form');
		$('button').on('click',function(e) {
			e.preventDefault();
			
			var operation = $(this).data('oper');
			if(operation === ' remove') {
				formObj.attr('action', '/board/remove');
			} else if(operation === 'list'){
				formObj.attr("action", "/board/list").attr("method","get");
				formObj.empty();
				formObj.append("<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>");
				formObj.append("<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>");
				formObj.append("<input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>");
				formObj.append("<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>");
			}
			formObj.submit();
		});
	});
</script>

<%@include file='../includes/footer.jsp' %>