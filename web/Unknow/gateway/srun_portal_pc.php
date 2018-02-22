
<html ng-app lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta http-equiv="pragma" content="no-cache" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>IP控制网关</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!--link href="202.118.1.88/css/style.css" rel="stylesheet" /-->
  <link rel="stylesheet" href="http://apps.neu.edu.cn/cdnjs/ajax/libs/twitter-bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="http://apps.neu.edu.cn/cdnjs/ajax/libs/twitter-bootstrap/3.3.4/css/bootstrap-theme.min.css"> 
  <link href="http://ipgw.neu.edu.cn:801/css/application.css?20141007000000" type="text/css" rel="stylesheet" media="all" />

  
  <script language="javascript" src="http://202.118.1.88:801/js/base64.js"></script>
  <script language="javascript" src="http://202.118.1.88:801/js/jquery.js"></script>
  <script language="javascript" src="http://202.118.1.88:801/js/srun_portal.js"></script>
  <script src="http://apps.neu.edu.cn/cdnjs/ajax/libs/twitter-bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="http://apps.neu.edu.cn/cdnjs/ajax/libs/angular.js/1.2.20/angular.min.js"></script>
  <script src="http://ipgw.neu.edu.cn:801/js/application.js?20141007000000"></script>
</head>

<body class="bottom">

  <!-- Begin container-->
  <div class="container">
    <div class="wrapper">
      <div class="header"><h1>IP控制网关</h1></div>

      <div class="toolbar hidden-xs">
        <ul class="nav nav-tabs" role="tablist">
          <li class="active"><a href="#">IP控制网关</a></li>
          <!--<li><a href="http://jifei.neu.edu.cn/user" target="_blank">计费自助服务</a></li>-->
          <li><a href="http://ipgw.neu.edu.cn:8800" target="_blank">上网费用查询</a></li>
          <li><a href="http://stu.neu.edu.cn" target="_blank">学生电子邮件</a></li>
          <li><a href="http://network.neu.edu.cn/portal/" target="_blank">IT服务门户</a></li>
        </ul>
      </div>

      <div class="content">
        <div class="row">
          <div class="col-lg-2 col-sm-3 hidden-xs">
             <ul class="list-group">
               <a class="list-group-item" href="http://jifei.neu.edu.cn/user/activity" target="_blank">自助开通上网账号</a>
               <a class="list-group-item" href="http://jifei.neu.edu.cn/user/password" target="_blank">忘记上网登录密码</a>
             </ul>
          </div>
      
          <div class="col-lg-10 col-sm-9">
            						
                          <form name="form2" action="http://ipgw.neu.edu.cn:801/srun_portal_pc.php?ac_id=1&url=" class="form-horizontal" method="post" onsubmit="return check(this)">
                <input type="hidden" name="action" value="login">
                <input type="hidden" name="ac_id" value="1">
                <input type="hidden" name="user_ip" value="">
                <input type="hidden" name="nas_ip" value="">
                <input type="hidden" name="user_mac" value="">
                <input type="hidden" name="url" value="" >

                <p></p>
                <div class="form-group">
                  <label class="col-sm-3 control-label" for="username">用户名(Username):</label>
                  <div class="col-sm-5">
                    <input class="form-control" type="text" name="username" size=35 value="" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-3 control-label" for="password">密&nbsp;&nbsp;码(Password):</label>
                  <div class="col-sm-5">
                    <input class="form-control" type="password" name="password" size=35 value="" />
                  </div>
                </div>

                <input name="save_me" title="记忆密码" type="hidden" value="0"  />
                <!--
                <div class="form-group">
                  <div class="col-sm-offset-3 col-sm-10">
                    <div class="checkbox">
                      <label>
                        <input name="save_me" title="记忆密码" type="checkbox" value="1"  /> 记住密码
                      </label>
                    </div>
                  </div>
                </div>
                -->
                <div class="form-group">
                  <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" value="连接网络(Connect)" class="btn btn-primary">
                    <input type="button" value="断开网络(Disconnect)" class="btn btn-default" onclick="do_logout()">
                    <input type="button" value="断开全部连接(Disconnect All)" class="btn btn-default" onclick="do_logout()">
                    <!--<input type="button" value="自服务" class="btn btn-success" onclick="window.open('http://202.118.1.88:8800')">-->
                  </div>
                </div>
              </form>
                      </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <div class="panel panel-default">
              <div class="panel-heading">最新网络中心黑板报</div>
              <div class="panel-body">
                <ul ng-controller="NetworkPostsController">
                  <li ng-repeat="post in posts">
                    <!--a target="_blank" ng-href="{{post.url}}"-->[{{post.date}}] {{post.title}}</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-xs-12">
            <div class="panel panel-default">
              <div class="panel-heading">常见问题与注意事项</div>
              <div class="panel-body">
                <ul>
                  <li>新系统月租月末结算, 余额信息为未收取当月月租，账户余额大于月租方可上网</li>
                  <li><a href="http://network.neu.edu.cn/archives/645">校园网续费时间调整为：上午8:00-11:30，下午14:30-16:00</a></li>
                  <li><a href="http://network.neu.edu.cn/archives/574">开学啦！忘记二次密码了么？通过密码直接更改二次密码吧！</a></li>
                  <li><a href="http://network.neu.edu.cn/archives/472">无线网络环境中使用校园网的注意事项</a></li>
                  <li><a href="http://ipgw.neu.edu.cn/faq.htm#yuanyin">P2P软件下载校内资源产生流量问题</a></li>
                  <li><a href="http://ipgw.neu.edu.cn/faq.htm#yuanyin">常见收费流量产生的原因</a> <a href="faq.htm">常见问题解答</a></li>
                  <li>
                    <a href="http://hdtv.neu6.edu.cn/newplayer?p=cctv5hd" target="_blank">CCTV5(高清)</a>
                    <a href="http://hdtv.neu6.edu.cn/newplayer?p=hunanhd" target="_blank">湖南卫视(高清)</a>
                    <a href="http://hdtv.neu6.edu.cn/newplayer?p=zjhd" target="_blank">浙江卫视(高清)</a>
                    <a href="http://hdtv.neu6.edu.cn/" target="_blank">更多...</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div class="well">
          <p>hello</p>
        </div>
      	<div class="well">
          <div class="pull-right hidden-xs">
            <img src="http://apps.neu.edu.cn/sunrise/assets/qrcode-132c52055446757da97fdc651a49f171.jpg" width="100px" />
          </div>
          <h4>注意：</h4>
          <p>1. 请务必在下机前到IP网关来断开您的连接，否则容易因意外流量损失自己的费用。重启机器前也要断开您的连接，养成良好的注册习惯。</p>
          <p>2. 网络中心电话：技术咨询 87240（校内小号）； 费用问题 87251（校内小号） </p>
        </div>
      </div>
    </div>
    <div class="footer">
      &copy; 1993-2013 Northeastern University Networking Center. All rights reserved.<br />
      缴费问题：83687251（外线），87251（内线）；技术咨询 83687240（外线），87240（内线）
    </div>
  </div>
  <!-- End container-->

</body>
</html>
