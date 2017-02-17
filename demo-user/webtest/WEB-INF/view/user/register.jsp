<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/jslibs.jsp"%>
<form:form id="userForm" modelAttribute="userDto" method="post"
   enctype="multipart/form-data">
   <table>
      <tr>
         <td align="right">Username:</td>
         <td>
            <form:input path="name" />
            <form:errors path="name" />
         </td>
      </tr>
      <tr>
         <td align="right">Password:</td>
         <td>
            <form:password path="passwd" />
         </td>
      </tr>
      <tr align="right">
         <td>
            <form:radiobutton path="gender" value="M" />
            Male
         </td>
         <td>
            <form:radiobutton path="gender" value="F" />
            Female
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
      <tr>
         <td align="right">Portrait:</td>
         <td>
            <input type="file" name="portrait" />
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
