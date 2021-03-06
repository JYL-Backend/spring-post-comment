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
                            		value='<c:out value="${board.title}"/>' readonly='readonly'>
                            	</div>
                            	<!-- 내용 -->
                            	<div class="form-group">
                            		<label>Text Area</label> 
                            		<textarea class="form-control" rows='3' name="content" readonly='readonly'>
                            		<c:out value="${board.content}"/>
                            		</textarea>  
                            	</div>
                            	<!-- 작성자 -->
                            	<div class="form-group">
                            		<label>Title</label> 
                            		<input class="form-control" name="writer" 
                            		value='<c:out value="${board.writer}"/>' readonly='readonly'>
                            	</div>
                            	<!-- 버튼 -->
                            	<button data-oper='modify' class='btn btn-default'>Modify</button>
                            	<button data-oper='list' class='btn btn-info'>List</button>
                            	<form id='operForm' action='/board/modify' method='get'>
                            		<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
                            		<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
                            		<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
                            		<input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
                            		<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
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
            
            <div class='row'>
            <!-- 댓글 출력 -->
            <!-- row -->
            	<div class='col-lg-12'>
            		<div class='panel panel-default'>
	            		<div class='panel-heading'>
	            			<i class='fa fa-comments fa-fw'></i> Reply
	            			<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
	            		</div>
	            		
	            		<div class='panel-body'>
	            			<ul class='chat'>
	            				<li class='left clearfix' data-rno='12'>
	            					<div>
	            						<div class='header'>
	            							<strong class='primary-font'>user00</strong>
	            							<small class='pull-right text-muted'>2018-01-01 13:13</small>
	            						</div>
	            						<p>Good job</p>
	            					</div>
	            				</li>
	            			</ul>
	            		</div>
	            		<div class='panel-footer'>
	            		</div>
            		</div>
            	</div>
            	
            </div>
            <!-- /row -->
            
            
<!-- 댓글 모달  -->
	<div class='modal fade' id='myModal' tabindex='-1' rol='dialog' aria-labelledby='myModalLabel' aria-hidden="true">
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>$times;</button>
					<h4 class='model-title' id='myModalLabel'>REPLY MODAL</h4>
				</div>
				<div class='modal-body'>
					<div class='form-group'>
						<label>Reply</label>
						<input class='form-control' name='reply' value='New Reply!!!'>
					</div>
					<div class='form-group'>
						<label>Replyer</label>
						<input class='form-control' name='replyer' value='replyer'>
					</div>
					<div class='form-group'>
						<label>Reply Date</label>
						<input class='form-control' name='replyDate' value=''>
					</div>
				</div>
				<div class='modal-footer'>
					<button id='modalModBtn' type='button' class='btn btn-warning'>Modify</button>
					<button id='modalRemoveBtn' type='button' class='btn btn-danger'>Remove</button>
					<button id='modalRegisterBtn' type='button' class='btn btn-primary'>Register</button>
					<button id='modalCloseBtn' type='button' class='btn btn-default'>Close</button>
				</div>
			</div>
		</div>
	</div>
<!-- /댓글 모달  -->

<!-- 댓글 js -->            
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
			var bnoValue = '<c:out value="${board.bno}"/>';
			var replyUL = $('.chat');
			
			showList(1);

			/* 댓글페이지목록 */
			function showList(page){
				replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt,list){
					
					if(page == -1){
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
					
					var str="";
					
					if(list==null || list.length==0){
						replyUL.html("");
						return;
					}
					for(var i=0, len=list.length||0 ; i<len; i++){
						str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>"
						str += "<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
						str += "<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
						str += "<p>"+list[i].reply+"</p></div></li>";
					}
					replyUL.html(str);
					showReplyPage(replyCnt);
				});
			}
			
			var modal = $(".modal");
			var modalInputReply = modal.find("input[name='reply']");
			var modalInputReplyer = modal.find("input[name='replyer']");
			var modalInputReplyDate = modal.find("input[name='replyDate']");
			
			var modalModBtn = $("#modalModBtn");
			var modalRemoveBtn = $("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");
			
			/* 댓글 모달창 open */
			$("#addReplyBtn").on("click", function(e){
				modal.find("input").val("");
				modalInputReplyDate.closest("div").hide();
				modal.find("button[id != 'modalCloseBtn']").hide();
				
				modalRegisterBtn.show();
				$(".modal").modal("show");
			});
			
			/* 댓글 등록확인 버튼  */
			modalRegisterBtn.on("click", function(e){
					var reply = {
						reply: modalInputReply.val(),
						replyer:modalInputReplyer.val(),
						bno:bnoValue
					};
					replyService.add(reply, function(result){
						alert(result);
						modal.find("input").val("");
						modal.modal("hide");

						showList(-1);
					});
			});
			/* 댓글 상세내용  */
			$('.chat').on('click', 'li', function(e){
				var rno = $(this).data('rno');
				replyService.get(rno,function(reply){
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
					.attr("readonly", "readonly");
					modal.data("rno", reply.rno);
					
					modal.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					$(".modal").modal("show");
				});
			});
			/* 댓글 수정 */
			modalModBtn.on("click", function(e){
				var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
				
				replyService.update(reply, function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			/* 댓글 삭제 */
			modalRemoveBtn.on("click", function(e){
				var rno = modal.data("rno");
				
				replyService.remove(rno, function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			
			/* 댓글 페이지 번호 출력 로직 */
			var pageNum = 1;
			var replyPageFooter = $(".panel-footer");
			
			function showReplyPage(replyCnt){
				var endNum = Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				
				var prev = startNum != 1;
				var next = false;
				
				if(endNum * 10 >= replyCnt){
					endNum = Math.ceil(replyCnt/10.0);
				}
				if(endNum * 10 < replyCnt){
					next = true;
				}
				
				var str = "<ul class='pagination pull-right'>";

				if(prev){
					str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
				}
				
				for( var i = startNum ; i<= endNum; i++){
					var active = pageNum == i? "active": "";
					str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
					
				}
				
				if(next){
					str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>NEXT</a></li>";
				}
				
				str += "</ul></div>";
				
				replyPageFooter.html(str);
				
			}
			/* 댓글 페이지번호 클릭시 불러오기 */
			replyPageFooter.on("click","li a", function(e){
					e.preventDefault();
					
					var targetPageNum = $(this).attr("href");
					pageNum = targetPageNum;
					showList(pageNum);
			});
			
	});
</script>

<script type='text/javascript'>
	$(document).ready(function(){
		var operForm = $('#operForm');

		$("button[data-oper='modify']").on('click', function(e){
			operForm.attr('action', '/board/modify').submit();
		});
		$("button[data-oper='list']").on('click', function(e){
			operForm.find('#bno').remove();
			operForm.attr('action', '/board/list');
			operForm.submit();
		});
	});
</script>
<%@include file='../includes/footer.jsp' %>