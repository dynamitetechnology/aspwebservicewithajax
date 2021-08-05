﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AspDotNetWebServiceCrud._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET WEB APP WITH WEB SERVICE</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    <div class="container">
        <div class="row">
          <div class="col-md-3">
              <label for="exampleInputEmail1">Serch</label>
              <input type="text" class="form-control  rounded-0 mb-3" id="serchtext">
          </div>
        </div>
        <table class="table">
            <caption>
                <button class="btn btn-success rounded-0" data-toggle="modal" data-target="#AddModal">Add User</button>
            </caption>
  <thead class="thead-dark">
    <tr>
      <th>Sr</th>
      <th>First</th>
      <th>Last</th>
      <th>Email</th>
    </tr>
  </thead>
  <tbody>
  <asp:Repeater ID="Repeaters1" runat="server">
   <ItemTemplate>
      <tr>
      <th><%#Eval("id")%></th>
      <td><%#Eval("fname")%></td>
      <td><%#Eval("lname")%></td>
      <td><%#Eval("email")%></td>
    </tr>
   </ItemTemplate>
</asp:Repeater>
  </tbody>
</table>
    </div>



    <!-- Modal -->
<div class="modal fade" id="AddModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content  rounded-0">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add User</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

  <div class="form-group">
    <label for="exampleInputEmail1">First Name</label>
    <input type="text" class="form-control rounded-0" id="fName">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Last Name</label>
    <input type="text" class="form-control  rounded-0" id="lName">
  </div>
    <div class="form-group">
    <label for="exampleInputPassword1">Email</label>
    <input type="text" class="form-control  rounded-0" id="email">
  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary  rounded-0 AddUser">Save</button>
      </div>
    </div>
  </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" ></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $(".AddUser").on('click', function () {
                let fName = $("#fName").val();
                let lName = $("#lName").val();
                let email = $("#email").val();
                console.log('fName', fName)
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebServices.asmx/AddUser",
                    dataType: "json",
                    data: "{'fName':'" + fName + "','lName': '" + lName + "', 'email': '" + email + "'}",
                    success: function (resp) {
                        console.log('resp', resp)
                    },

                });
            })

            //Search Web Service 
            $("#serchtext").on('keydown', () => {
                let serchtext = $("#serchtext").val()
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebServices.asmx/SearchUsers",
                    dataType: "json",
                    data: "{'searchKey':'" + serchtext + "'}",
                    success: function (resp) {
                        console.log('resp', resp)
                    },

                });
            })
        })
    </script>
</asp:Content>
 