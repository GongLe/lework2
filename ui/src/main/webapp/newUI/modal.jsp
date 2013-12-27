<%--
  Created by IntelliJ IDEA.
  User: Gongle
  Date: 13-12-25
  Time: 下午7:43
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<body>

<div class="modal-box">
    <form class="form-horizontal"  id="formInput" role="form" style="padding: 0;margin: 0;">
        <div class="modal-box-header">
            <h4 class="modal-box-title">Modal title</h4>
        </div>
        <div class="modal-box-body">

            <div class="form-group">
                <label class="col-sm-2 control-label">Email</label>

                <div class="col-sm-10">
                    <p class="form-control-static">email@example.com</p>
                </div>
            </div>
            <div class="form-group">
                <label for="inputPassword" class="col-sm-2 control-label">Password</label>

                <div class="col-sm-6">
                    <input type="password" class="form-control" id="inputPassword" name="inputPassword" placeholder="Password">
                </div>
            </div>
            <div class="form-group">
                <label for="inputPassword" class="col-sm-2 control-label">Password</label>

                <div class="col-sm-6">
                    <input type="text" class="form-control" name="name" placeholder="name">
                </div>
            </div>
            <div class="form-group">
                <label for="inputPassword" class="col-sm-2 control-label">Password</label>

                <div class="col-sm-6">
                    <input type="text" class="form-control" placeholder="name">
                </div>
            </div>
            <div class="form-group">
                <label for="inputPassword" class="col-sm-2 control-label">Password</label>

                <div class="col-sm-6">
                    <input type="text" class="form-control" placeholder="name">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">select</label>

                <div class="col-sm-6">
                    <select class="form-control" name="selectEle">
                        <option>--select--</option>
                        <option value="111">--1111--</option>
                        <option value="2222">--222--</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">select</label>

                <div class="col-sm-6" style="vertical-align: middle">
                    <div class="form-control">
                        <input type="checkbox"> Check me out
                    </div>
                </div>
            </div>


        </div>
        <div class="modal-box-footer">
            <button type="button" class="btn btn-default btn-sm">关闭</button>
            <button type="submit" class="btn btn-primary btn-sm">保存</button>
        </div>
    </form>
</div>
<!-- /.modal-box -->
  <script>
  $(function(){
      $('#formInput').validate({
          rules: {
              selectEle: {
                  minlength: 3,
                  maxlength: 15,
                  required: true
              },
              name: {
                  minlength: 3,
                  maxlength: 15,
                  required: true
              },
              inputPassword: {
                  minlength: 3,
                  maxlength: 15,
                  required: true
              }
          },
          highlight: function(element) {
              $(element).closest('.form-group').addClass('has-error');
          },
          unhighlight: function(element) {
              $(element).closest('.form-group').removeClass('has-error');
          },
        /*  errorClass: "errormessage",
          onkeyup: false,
          errorClass: 'error',
          validClass: 'valid',*/
          errorElement: 'span',
         errorClass: 'help-block',
          errorPlacement: function(error, element) {
              if(element.parent('.input-group').length) {
                  error.insertAfter(element.parent());
              } else {
                  error.insertAfter(element);
              }
          }

      });
  })

  </script>
</body>
</html>