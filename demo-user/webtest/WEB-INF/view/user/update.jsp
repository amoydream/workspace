<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/jslibs.jsp"%>
<form:form id="userForm" modelAttribute="userDto" method="post">
   <form:hidden path="id" />
   <table>
      <tr>
         <td align="right">Username:</td>
         <td>
            <form:input path="name" />
            <form:errors path="name" />
         </td>
      </tr>
      <%-- <tr>
            <td align="right">Birthday: </td><td><form:input path="birthday" /></td>
         </tr> --%>
      <tr>
         <td align="right">Address:</td>
         <td>
            <form:input path="address" />
         </td>
      </tr>
      <tr>
         <td align="right">Phone:</td>
         <td>
            <form:input path="phone" />
         </td>
      </tr>
      <tr>
         <td align="right">Email:</td>
         <td>
            <form:input path="email" />
            <form:errors path="email" />
         </td>
      </tr>
      <tr align="right">
         <td colspan="2">
            <input type="reset" value="Reset" style="width: 30%;" />
            &nbsp;&nbsp;
            <input type="submit" value="Submit" style="width: 30%;" />
         </td>
      </tr>
   </table>
</form:form>
