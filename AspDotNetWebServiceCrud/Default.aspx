<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AspDotNetWebServiceCrud._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET WEB APP WITH WEB SERVICE</h1>
        <p class="lead">ASP.NET Web Service Using jQuery Ajax With Crud</p>
        <p><a href="http://www.dynamitetechnology.in" class="btn btn-primary btn-lg">Contact us</a></p>
    </div>

    <div class="container">
        <div class="row">
          <div class="col-md-3">
              <label for="exampleInputEmail1">Serch</label>
              <input type="text" class="form-control  rounded-0 mb-3" id="serchtext">
          </div>
        </div>
        <table class="table" id="searchResult">
            <caption>
                <button class="btn btn-success rounded-0" data-toggle="modal" data-target="#AddModal">Add User</button>
            </caption>
  <thead class="thead-dark" >
    <tr>
      <th>Sr</th>
      <th>First</th>
      <th>Last</th>
      <th>Email</th>
         <th>Action</th>
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
      <td><a class="editModal" data-edit = "<%#Eval("id")%>"><i class="bi bi-pencil-square"></i></a>
          <a class="deletedata" data-id = "<%#Eval("id")%>"><i class="bi bi-trash"></i></a>
      </td>
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
       <a type="button" class="btn btn-danger  rounded-0 success-btn d-none" data-dismiss="modal">Success</a>
                 <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Close</button>
                 <button type="button" class="btn btn-primary  rounded-0 AddUser">Save</button>
          </div>
      </div>
    </div>
  </div>



    <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content  rounded-0">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Edit User</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
  <div class="form-group">
    <label for="exampleInputEmail1">First Name</label>
    <input type="text" class="form-control rounded-0" id="mfName">
       <input type="hidden" class="form-control rounded-0" id="mid">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Last Name</label>
    <input type="text" class="form-control  rounded-0" id="mlName">
  </div>
    <div class="form-group">
    <label for="exampleInputPassword1">Email</label>
    <input type="text" class="form-control  rounded-0" id="memail">
  </div>
      </div>
      <div class="modal-footer">
                 <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Close</button>
                 <button type="button" class="btn btn-primary  rounded-0 updateInfo">Update</button>
          </div>
      </div>
    </div>
  </div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" ></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#searchResult').DataTable();
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
                        $(".success-btn").removeClass('d-none')

                        setTimeout(function () {
                            $("#AddModal").modal('hide');
                            location.reload()
                        }, 1500);
                       
                        console.log('resp', resp.d)
                    },
                });
            })

            //Search Web Service 
            $("#serchtext").on('keyup', () => {
                let serchtext = $("#serchtext").val()
                let tableResult = ``;
                tableResult = `<table class="table">
                                    <caption>
                                        <button class="btn btn-success rounded-0" data-toggle="modal" data-target="#AddModal">Add User</button>
                                    </caption>
                          <thead class="thead-dark" id="searchResult">
                            <tr>
                              <th>Sr</th>
                              <th>First</th>
                              <th>Last</th>
                              <th>Email</th>
                            </tr>
                          </thead>
                          <tbody>`;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebServices.asmx/SearchUsers",
                    dataType: "json",
                    data: "{'searchKey':'" + serchtext + "'}",
                    success: function (resp) {
                        console.log('resp', resp)
                        let result = JSON.parse(resp.d);
                        console.log('result===========>',result)
                        result.forEach((item) => {
                            tableResult += `
                              <tr>
                              <th>${item.id}</th>
                              <td>${item.fname}</td>
                              <td>${item.lname}</td>
                              <td>${item.email}</td>
                            </tr>`;
                        })
                        tableResult += `<tbody></table>`;
                        $("#searchResult").html(tableResult)
                    },
                });
            })

            //Get Edit Data
            $("#searchResult").on('click', '.editModal', function () {
                let editid = $(this).attr("data-edit")
                console.log('editid---------->', editid)
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebServices.asmx/getEingleUser",
                    dataType: "json",
                    data: "{'editid':'" + editid + "'}",
                    success: function (resp) {
                        //console.log('resp', resp.d)

                        let response = JSON.parse(resp.d);
                        console.log('response--->', response)

                        response.forEach(function (itm) {
                            console.log('itm--->', itm)
                            $("#mfName").val(itm.fname)
                            $("#mlName").val(itm.lname)
                            $("#memail").val(itm.email)
                            $("#mid").val(itm.id)
                        })
                        $("#updateModal").modal('show')
                       
                    },
                });
            })



            //Get Update Data
            $(".updateInfo").on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebServices.asmx/UpdateUser",
                    dataType: "json",
                    data: "{'id':'" + $("#mid").val()+"','fname':'" + $("#mfName").val() + "','lname':'" + $("#mlName").val() + "','email':'" + $("#memail").val()+"'}",
                    success: function (resp) {
                        //console.log('resp', resp.d)
                        location.reload()
                        let response = resp.d;
                        console.log('response--->', response)
                    },
                });
            })


            //Delete
            $("#searchResult").on('click', '.deletedata', function () {
                let editid = $(this).attr("data-id")
                console.log('editid---------->', editid)
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebServices.asmx/deleteuser",
                    dataType: "json",
                    data: "{'editid':'" + editid + "'}",
                    success: function (resp) {
                        //console.log('resp', resp.d)
                        location.reload()
                        let response = resp.d;
                        console.log('response--->', response)

                    },
                });
            })
        })
    </script>
</asp:Content>
 