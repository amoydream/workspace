/*分页调用函数*/
function _gotoPage(pageNumber) {
	try{
		var tableForm = document.getElementById('mainForm');
		tableForm.pageNumber.value = pageNumber;
		tableForm.onsubmit=null;
		tableForm.submit();//提交到对应的action再执行
	} catch(e) {
		alert('gotoPage(pageNumber)方法出错或不存在');
	}
}