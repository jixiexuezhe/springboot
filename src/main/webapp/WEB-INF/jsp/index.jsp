    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>
        <head>
        <title>Tables</title>
        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="assets/styles.css" rel="stylesheet" media="screen">
        <link href="assets/DT_bootstrap.css" rel="stylesheet" media="screen">
        <!--[if lte IE 8]><script language="javascript" type="text/javascript"
        src="vendors/flot/excanvas.min.js"></script><![endif]-->
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script src="vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
        <script src="vendors/jquery-1.9.1.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="vendors/datatables/js/jquery.dataTables.min.js"></script>
        <script src="js/react.js"></script>
        <script src="js/JSXTransformer.js"></script>
        <script src="assets/scripts.js"></script>
        <script src="assets/DT_bootstrap.js"></script>
        </head>
        <body>
        <div class="navbar navbar-fixed-top">
        </div>
        <div class="container-fluid">
        <div class="row-fluid">
        <div class="span3" id="sidebar">
        <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
        <li class="active" id="disManagerButton">
        <a onclick="disclineManager()" href="#"><i class="icon-chevron-right"></i> disclineManagerment </a>
        </li>
        <li  id="stuManagerButton">
        <a onclick="studentManager()" href="#"><i class="icon-chevron-right"></i> studentManagerment</a>
        </li>
        <li  id="uploadFile">
        <a onclick="uploadFile()" href="#"><i class="icon-chevron-right"></i> studentManagerment</a>
        </li>
        </ul>
        </div>
        <div class="span9" id="content">
        <div class="row-fluid">
        <div class="block">
        <div class="navbar navbar-inner block-header">
        <div class="muted pull-left">Bootstrap dataTables</div>
        </div>
        <div class="block-content collapse in">
        <div class="span12">
        <div id="jquerydatatable">
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        <hr>
        <footer>
        <p>&copy; Vincent Gabriel 2013</p>
        </footer>
        </div>
        <script type="text/jsx">
        var DisclineModalComponent = React.createClass({
        getInitialState : function(){
        return ({data : []});
        },
        componentDidMount : function(){
        var name = this.props.name;
        $.ajax({
        url : '/loadAllTeachers',
        dataType : 'json',
        cache : false,
        success : function(data){
        this.setState({data : data});
        }.bind(this)
        });
        React.render(<StuComponent />,document.getElementById('professionSelectedstudentTable'));
        },
        render : function(){
        var self = this;
        var teacherArray = this.props.teachers.split(",");
        var allTeachers = this.state.data;
        return (
        <div className="modal fade" id={self.props.name} tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div className="modal-dialog">
        <div className="modal-content">
        <div className="modal-header">
        <button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 className="modal-title" id="myModalLabel">编辑信息</h4>
        </div>
        <div className="modal-body">
        <form name="Edit" action="/admitEditDiscline" method="get">
        <div class="control-group">
        <label class="control-label" text="input01">专业方向</label>
        <div class="controls">
        <input type="text" name="profession" value={this.props.profession} readonly="readonly" class="input-xlarge"></input>
        </div>
        </div>
        <div class="control-group">
        <label class="control-label" text="input01">方向介绍</label>
        <div class="controls">
        <textarea class="form-control" name="induction" defaultValue={this.props.induction}></textarea>
        </div>
        </div>
        <div class="control-group">
        <label class="control-label" text="input01">教学计划</label>
        <div class="controls">
        <textarea class="form-control" name="teachPlan" defaultValue={this.props.teachPlan}></textarea>
        </div>
        </div>
        <div class="control-group">
        <label class="control-label" text="input01">实习基地</label>
        <div class="controls">
        <input type="text" name="praticeBase" defaultValue={this.props.praticeBase}  class="input-xlarge"></input>
        </div>
        </div>


        <div class="control-group">
        <label class="control-label" text="input01">实习基地</label>
        <div class="controls">
        <div id="professionSelectedstudentTable"></div>
        </div>
        </div>


        <div class="control-group">
        <label class="control-label" text="input01">师资力量</label>
        <div class="controls">
        <div className="btn-group" data-toggle="buttons">
        {
        allTeachers.map(function(teacher){
        if(teacherArray.indexOf(teacher)>-1){
        return (
        <label class="btn btn-primary" active>
        <input type="checkbox" name="teachers" autocomplete="off" defaultChecked value={teacher}>{teacher}</input>
        </label>);}
        else{
        return (
        <label class="btn btn-primary">
        <input type="checkbox" name="teachers" autocomplete="off" value={teacher}>{teacher}</input>
        </label>
        );
        }
        })
        }
        </div>

        </div>
        </div>
        <input type="submit"></input>
        </form>
        </div>
        <div className="modal-footer">
        </div>
        </div>
        </div>
        </div>
        );
        }
        });






        var StudentModalComponent = React.createClass({
        getInitialState : function(){
        return ({data : {},professions:[]});
        },
        componentDidMount : function(){
        var id = this.props.id;
        $.ajax({
        url : '/student-'+id ,
        dataType : 'json',
        cache : false,
        success : function(data){
        this.setState({data : data,professions : this.state.professions});
        }.bind(this)
        });

        $.ajax({
        url : '/loadAllProfession',
        dataType : 'json',
        cache : false,
        success : function(professions){
            this.setState({data : this.state.data,professions : professions});
        }.bind(this)
        });
        },
        render : function(){

        var self = this;
        var row = this.props;
        return (
        <div className="modal fade" id={this.props.name} tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div className="modal-dialog">
        <div className="modal-content">
        <div className="modal-header">
        <button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 className="modal-title" id="studentModalLabel">编辑信息</h4>
        </div>
        <div className="modal-body">
        <form name="Edit" action="/admitEditStudent" method="get">


        <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
        <tr>
        <th>编号</th>
        <th>报名点代码</th>
        <th>报名地点</th>
        <th>报名点邮编</th>
        <th>报名号</th>
        <th>姓名</th>
        <th>姓名拼音</th>
        <th>性别</th>
        <th>籍贯所在地</th>
        <th>婚姻</th>
        <th>出生日期</th>
        <th>移动电话</th>
        <th>电子信箱</th>
        <th>本毕业单位</th>
        <th>本毕业专业</th>
        <th>民族</th>
        <th>民族码</th>
        <th>本科毕年月</th>
        <th>毕业省市码</th>
        <th>毕单位省市</th>
        <th>本科毕证号</th>
        <th>考试地点</th>
        <th>政治面貌码</th>
        <th>政治面貌</th>
        <th>在校生学号</th>
        <th>学历码</th>
        <th>原学历</th>
        <th>学士证书号</th>
        <th>学位码</th>
        <th>原学位</th>
        <th>录取类别码</th>
        <th>录取类别</th>
        <th>入学方式码</th>
        <th>入学方式</th>
        <th>考试方式码</th>
        <th>自编专业码</th>
        <th>专业代码</th>
        <th>专业名称</th>
        <th>研究方向码</th>
        <th>研究方向</th>
        <th>报考单位码</th>
        <th>报考单位</th>
        <th>第二志愿</th>
        <th>第二志愿码</th>
        <th>导师编号</th>
        <th>导师</th>
        <th>导师职称</th>
        <th>系所码</th>
        <th>系所</th>
        <th>学院</th>
        <th>外国语码</th>
        <th>外语</th>
        <th>政治理论码</th>
        <th>政治</th>
        <th>业务课1码</th>
        <th>业务课1</th>
        <th>业务课2码</th>
        <th>业务课2</th>
        <th>专业方向</th>
        </tr>
        </thead>
        <tbody>
        <tr>
        <td>{row.id}<input type="hidden" name="id" value={row.id}></input></td>
        <td>{row.baomingdiandaima+""}</td>
        <td>{row.baomingdidian+""}</td>
        <td>{row.baomingdianyoubian+""}</td>
        <td>{row.baominghao+""}</td>
        <td>{row.xingming+""}</td>
        <td>{row.xingmingpinyin+""}</td>
        <td>{row.xingbie+""}</td>
        <td>{row.jiguansuozaidi+""}</td>
        <td>{row.hunyin+""}</td>
        <td>{row.chushengriqi+""}</td>
        <td>{row.yidongdianhua+""}</td>
        <td>{row.dianzixinxiang+""}</td>
        <td>{row.benbiyedanwei+""}</td>
        <td>{row.benbiyezhuanye+""}</td>
        <td>{row.minzu+""}</td>
        <td>{row.minzuma+""}</td>
        <td>{row.benkebinianyue+""}</td>
        <td>{row.biyeshengshima+""}</td>
        <td>{row.bidanweishengshi+""}</td>
        <td>{row.benkebizhenghao+""}</td>
        <td>{row.kaoshididian+""}</td>
        <td>{row.zhengzhimianmaoma+""}</td>
        <td>{row.zhengzhimianmao+""}</td>
        <td>{row.zaixiaoshengxuehao+""}</td>
        <td>{row.xuelima+""}</td>
        <td>{row.yuanxueli+""}</td>
        <td>{row.xueshizhengshuhao+""}</td>
        <td>{row.xueweima+""}</td>
        <td>{row.yuanxuewei+""}</td>
        <td>{row.luquleibiema+""}</td>
        <td>{row.luquleibie+""}</td>
        <td>{row.ruxuefangshima+""}</td>
        <td>{row.ruxuefangshi+""}</td>
        <td>{row.kaoshifangshima+""}</td>
        <td>{row.zibianzhuanyema+""}</td>
        <td>{row.zhuanyedaima+""}</td>
        <td>{row.zhuanyemingchen+""}</td>
        <td>{row.yanjiufangxiangma+""}</td>
        <td>{row.yanjiufangxiang+""}</td>
        <td>{row.baokaodanweima+""}</td>
        <td>{row.baokaodanwei+""}</td>
        <td>{row.dierzhiyuan+""}</td>
        <td>{row.dierzhiyuanma+""}</td>
        <td>{row.daoshibianhao+""}</td>
        <td>{row.daoshi+""}</td>
        <td>{row.daoshizhicheng+""}</td>
        <td>{row.xisuoma+""}</td>
        <td>{row.xisuo+""}</td>
        <td>{row.xueyuan+""}</td>
        <td>{row.waiguoyuma+""}</td>
        <td>{row.waiyu+""}</td>
        <td>{row.zhengzhililunma+""}</td>
        <td>{row.zhengzhi+""}</td>
        <td>{row.yewuke1ma+""}</td>
        <td>{row.yewuke1+""}</td>
        <td>{row.yewuke2ma+""}</td>
        <td>{row.yewuke2+""}</td>
        <td>


        <select name="zhuanyefangxiang" class="form-control">
        <option default>{row.zhuanyefangxiang}</option>,
        {
        this.state.professions.map(function(profession){
                if(profession!==row.zhuanyefangxiang){return ( <option>{profession}</option>);}
        })

        }
        </select>
        </td>
        </tr>
        </tbody>
        </table>
        <input type="submit"></input>
        </form>
        </div>
        <div className="modal-footer">
        </div>
        </div>
        </div>
        </div>
        );
        }
        });

        var StuComponent = React.createClass({
        getInitialState : function(){
        return ({data : []});
        },
        componentDidMount : function(){
        $.ajax({
        url : '/loadStudentList',
        dataType : 'json',
        cache : false,
        success : function(data){
        this.setState({data : data});
        }.bind(this)
        });
        },
        componentDidUpdate : function(){
        $('#studentTable').dataTable({
        "sPaginationType": "bootstrap",
        "bAutoWidth": false,
        "bDestroy": true,
        "scrollX": true,
        "fnDrawCallback": function() {
        //self.forceUpdate();
        }
        });

        var table = $('#studentTable').dataTable();
        $('#studentTable tbody').on( 'click', 'tr', function () {


        var selectTr = $(this)[0];
        var id = (selectTr.childNodes[0].firstChild == null) ? " " : selectTr.childNodes[0].firstChild.data;
        var baomingdiandaima = (selectTr.childNodes[1].firstChild == null) ? " " : selectTr.childNodes[1].firstChild.data;
        var baomingdidian = (selectTr.childNodes[2].firstChild == null) ? " " : selectTr.childNodes[2].firstChild.data;
        var baomingdianyoubian = (selectTr.childNodes[3].firstChild == null) ? " " : selectTr.childNodes[3].firstChild.data;
        var baominghao = (selectTr.childNodes[4].firstChild == null) ? " " : selectTr.childNodes[4].firstChild.data;
        var xingming = (selectTr.childNodes[5].firstChild == null) ? " " : selectTr.childNodes[5].firstChild.data;
        var xingmingpinyin = (selectTr.childNodes[6].firstChild == null) ? " " : selectTr.childNodes[6].firstChild.data;
        var xingbie = (selectTr.childNodes[7].firstChild == null) ? " " : selectTr.childNodes[7].firstChild.data;
        var jiguansuozaidi = (selectTr.childNodes[8].firstChild == null) ? " " : selectTr.childNodes[8].firstChild.data;
        var hunyin = (selectTr.childNodes[9].firstChild == null) ? " " : selectTr.childNodes[9].firstChild.data;
        var chushengriqi = (selectTr.childNodes[10].firstChild == null) ? " " : selectTr.childNodes[10].firstChild.data;
        var yidongdianhua = (selectTr.childNodes[11].firstChild == null) ? " " : selectTr.childNodes[11].firstChild.data;
        var dianzixinxiang = (selectTr.childNodes[12].firstChild == null) ? " " : selectTr.childNodes[12].firstChild.data;
        var benbiyedanwei = (selectTr.childNodes[13].firstChild == null) ? " " : selectTr.childNodes[13].firstChild.data;
        var benbiyezhuanye = (selectTr.childNodes[14].firstChild == null) ? " " : selectTr.childNodes[14].firstChild.data;
        var minzu = (selectTr.childNodes[15].firstChild == null) ? " " : selectTr.childNodes[15].firstChild.data;
        var minzuma = (selectTr.childNodes[16].firstChild == null) ? " " : selectTr.childNodes[16].firstChild.data;
        var benkebinianyue = (selectTr.childNodes[17].firstChild == null) ? " " : selectTr.childNodes[17].firstChild.data;
        var biyeshengshima = (selectTr.childNodes[18].firstChild == null) ? " " : selectTr.childNodes[18].firstChild.data;
        var bidanweishengshi = (selectTr.childNodes[19].firstChild == null) ? " " : selectTr.childNodes[19].firstChild.data;
        var benkebizhenghao = (selectTr.childNodes[20].firstChild == null) ? " " : selectTr.childNodes[20].firstChild.data;
        var kaoshididian = (selectTr.childNodes[21].firstChild == null) ? " " : selectTr.childNodes[21].firstChild.data;
        var zhengzhimianmaoma = (selectTr.childNodes[22].firstChild == null) ? " " : selectTr.childNodes[22].firstChild.data;
        var zhengzhimianmao = (selectTr.childNodes[23].firstChild == null) ? " " : selectTr.childNodes[23].firstChild.data;
        var zaixiaoshengxuehao = (selectTr.childNodes[24].firstChild == null) ? " " : selectTr.childNodes[24].firstChild.data;
        var xuelima = (selectTr.childNodes[25].firstChild == null) ? " " : selectTr.childNodes[25].firstChild.data;
        var yuanxueli = (selectTr.childNodes[26].firstChild == null) ? " " : selectTr.childNodes[26].firstChild.data;
        var xueshizhengshuhao = (selectTr.childNodes[27].firstChild == null) ? " " : selectTr.childNodes[27].firstChild.data;
        var xueweima = (selectTr.childNodes[28].firstChild == null) ? " " : selectTr.childNodes[28].firstChild.data;
        var yuanxuewei = (selectTr.childNodes[29].firstChild == null) ? " " : selectTr.childNodes[29].firstChild.data;
        var luquleibiema = (selectTr.childNodes[30].firstChild == null) ? " " : selectTr.childNodes[30].firstChild.data;
        var luquleibie = (selectTr.childNodes[31].firstChild == null) ? " " : selectTr.childNodes[31].firstChild.data;
        var ruxuefangshima = (selectTr.childNodes[32].firstChild == null) ? " " : selectTr.childNodes[32].firstChild.data;
        var ruxuefangshi = (selectTr.childNodes[33].firstChild == null) ? " " : selectTr.childNodes[33].firstChild.data;
        var kaoshifangshima = (selectTr.childNodes[34].firstChild == null) ? " " : selectTr.childNodes[34].firstChild.data;
        var zibianzhuanyema = (selectTr.childNodes[35].firstChild == null) ? " " : selectTr.childNodes[35].firstChild.data;
        var zhuanyedaima = (selectTr.childNodes[36].firstChild == null) ? " " : selectTr.childNodes[36].firstChild.data;
        var zhuanyemingchen = (selectTr.childNodes[37].firstChild == null) ? " " : selectTr.childNodes[37].firstChild.data;
        var yanjiufangxiangma = (selectTr.childNodes[38].firstChild == null) ? " " : selectTr.childNodes[38].firstChild.data;
        var yanjiufangxiang = (selectTr.childNodes[39].firstChild == null) ? " " : selectTr.childNodes[39].firstChild.data;
        var baokaodanweima = (selectTr.childNodes[40].firstChild == null) ? " " : selectTr.childNodes[40].firstChild.data;
        var baokaodanwei = (selectTr.childNodes[41].firstChild == null) ? " " : selectTr.childNodes[41].firstChild.data;
        var dierzhiyuan = (selectTr.childNodes[42].firstChild == null) ? " " : selectTr.childNodes[42].firstChild.data;
        var dierzhiyuanma = (selectTr.childNodes[43].firstChild == null) ? " " : selectTr.childNodes[43].firstChild.data;
        var daoshibianhao = (selectTr.childNodes[44].firstChild == null) ? " " : selectTr.childNodes[44].firstChild.data;
        var daoshi = (selectTr.childNodes[45].firstChild == null) ? " " : selectTr.childNodes[45].firstChild.data;
        var daoshizhicheng = (selectTr.childNodes[46].firstChild == null) ? " " : selectTr.childNodes[46].firstChild.data;
        var xisuoma = (selectTr.childNodes[47].firstChild == null) ? " " : selectTr.childNodes[47].firstChild.data;
        var xisuo = (selectTr.childNodes[48].firstChild == null) ? " " : selectTr.childNodes[48].firstChild.data;
        var xueyuan = (selectTr.childNodes[48].firstChild == null) ? " " : selectTr.childNodes[48].firstChild.data;
        var waiguoyuma = (selectTr.childNodes[50].firstChild == null) ? " " : selectTr.childNodes[50].firstChild.data;
        var waiyu = (selectTr.childNodes[51].firstChild == null) ? " " : selectTr.childNodes[51].firstChild.data;
        var zhengzhililunma = (selectTr.childNodes[52].firstChild == null) ? " " : selectTr.childNodes[52].firstChild.data;
        var zhengzhi = (selectTr.childNodes[53].firstChild == null) ? " " : selectTr.childNodes[53].firstChild.data;
        var yewuke1ma = (selectTr.childNodes[54].firstChild == null) ? " " : selectTr.childNodes[54].firstChild.data;
        var yewuke1 = (selectTr.childNodes[55].firstChild == null) ? " " : selectTr.childNodes[55].firstChild.data;
        var yewuke2ma = (selectTr.childNodes[56].firstChild == null) ? " " : selectTr.childNodes[56].firstChild.data;
        var yewuke2 = (selectTr.childNodes[57].firstChild == null) ? " " : selectTr.childNodes[57].firstChild.data;
        var zhuanyefangxiang = (selectTr.childNodes[58].firstChild == null) ? " " : selectTr.childNodes[58].firstChild.data;


        React.render(<StudentModalComponent name="studentModal"
                    id={id}
                    baomingdiandaima={baomingdiandaima}
                    baomingdidian={baomingdidian}
                    baomingdianyoubian={baomingdianyoubian}
                    baominghao={baominghao}
                    xingming={xingming}
                    xingmingpinyin={xingmingpinyin}
                    xingbie={xingbie}
                    jiguansuozaidi={jiguansuozaidi}
                    hunyin={hunyin}
                    chushengriqi={chushengriqi}
                    yidongdianhua={yidongdianhua}
                    dianzixinxiang={dianzixinxiang}
                    benbiyedanwei={benbiyedanwei}
                    benbiyezhuanye={benbiyezhuanye}
                    minzu={minzu}
                    minzuma={minzuma}
                    benkebinianyue={benkebinianyue}
                    biyeshengshima={biyeshengshima}
                    bidanweishengshi={bidanweishengshi}
                    benkebizhenghao={benkebizhenghao}
                    kaoshididian={kaoshididian}
                    zhengzhimianmaoma={zhengzhimianmaoma}
                    zhengzhimianmao={zhengzhimianmao}
                    zaixiaoshengxuehao={zaixiaoshengxuehao}
                    xuelima={xuelima}
                    yuanxueli={yuanxueli}
                    xueshizhengshuhao={xueshizhengshuhao}
                    xueweima={xueweima}
                    yuanxuewei={yuanxuewei}
                    luquleibiema={luquleibiema}
                    luquleibie={luquleibie}
                    ruxuefangshima={ruxuefangshima}
                    ruxuefangshi={ruxuefangshi}
                    kaoshifangshima={kaoshifangshima}
                    zibianzhuanyema={zibianzhuanyema}
                    zhuanyedaima={zhuanyedaima}
                    zhuanyemingchen={zhuanyemingchen}
                    yanjiufangxiangma={yanjiufangxiangma}
                    yanjiufangxiang={yanjiufangxiang}
                    baokaodanweima={baokaodanweima}
                    baokaodanwei={baokaodanwei}
                    dierzhiyuan={dierzhiyuan}
                    dierzhiyuanma={dierzhiyuanma}
                    daoshibianhao={daoshibianhao}
                    daoshi={daoshi}
                    daoshizhicheng={daoshizhicheng}
                    xisuoma={xisuoma}
                    xisuo={xisuo}
                    xueyuan={xueyuan}
                    waiguoyuma={waiguoyuma}
                    waiyu={waiyu}
                    zhengzhililunma={zhengzhililunma}
                    zhengzhi={zhengzhi}
                    yewuke1ma={yewuke1ma}
                    yewuke1={yewuke1}
                    yewuke2ma={yewuke2ma}
                    yewuke2={yewuke2}
                    zhuanyefangxiang={zhuanyefangxiang}
        />,document.getElementById('stuModal'));
        var modal = $('#studentModal').modal('show');
        });
        },
        render : function(){
        var self = this;
        return(
        <div class="table-responsive">
        <div id="stuModal"></div>
        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="studentTable">
        <thead>
        <tr>
        <th>编号</th>
        <th>报名点代码</th>
        <th>报名地点</th>
        <th>报名点邮编</th>
        <th>报名号</th>
        <th>姓名</th>
        <th>姓名拼音</th>
        <th>性别</th>
        <th>籍贯所在地</th>
        <th>婚姻</th>
        <th>出生日期</th>
        <th>移动电话</th>
        <th>电子信箱</th>
        <th>本毕业单位</th>
        <th>本毕业专业</th>
        <th>民族</th>
        <th>民族码</th>
        <th>本科毕年月</th>
        <th>毕业省市码</th>
        <th>毕单位省市</th>
        <th>本科毕证号</th>
        <th>考试地点</th>
        <th>政治面貌码</th>
        <th>政治面貌</th>
        <th>在校生学号</th>
        <th>学历码</th>
        <th>原学历</th>
        <th>学士证书号</th>
        <th>学位码</th>
        <th>原学位</th>
        <th>录取类别码</th>
        <th>录取类别</th>
        <th>入学方式码</th>
        <th>入学方式</th>
        <th>考试方式码</th>
        <th>自编专业码</th>
        <th>专业代码</th>
        <th>专业名称</th>
        <th>研究方向码</th>
        <th>研究方向</th>
        <th>报考单位码</th>
        <th>报考单位</th>
        <th>第二志愿</th>
        <th>第二志愿码</th>
        <th>导师编号</th>
        <th>导师</th>
        <th>导师职称</th>
        <th>系所码</th>
        <th>系所</th>
        <th>学院</th>
        <th>外国语码</th>
        <th>外语</th>
        <th>政治理论码</th>
        <th>政治</th>
        <th>业务课1码</th>
        <th>业务课1</th>
        <th>业务课2码</th>
        <th>业务课2</th>
        <th>专业方向</th>
        </tr>
        </thead>
        <tbody>
        {this.state.data.map(function A(row){
        return (
        <tr style={{cursor:'pointer'}}>
        <td>{row.id+""}</td>
        <td>{row.baomingdiandaima+""}</td>
        <td>{row.baomingdidian+""}</td>
        <td>{row.baomingdianyoubian+""}</td>
        <td>{row.baominghao+""}</td>
        <td>{row.xingming+""}</td>
        <td>{row.xingmingpinyin+""}</td>
        <td>{row.xingbie+""}</td>
        <td>{row.jiguansuozaidi+""}</td>
        <td>{row.hunyin+""}</td>
        <td>{row.chushengriqi+""}</td>
        <td>{row.yidongdianhua+""}</td>
        <td>{row.dianzixinxiang+""}</td>
        <td>{row.benbiyedanwei+""}</td>
        <td>{row.benbiyezhuanye+""}</td>
        <td>{row.minzu+""}</td>
        <td>{row.minzuma+""}</td>
        <td>{row.benkebinianyue+""}</td>
        <td>{row.biyeshengshima+""}</td>
        <td>{row.bidanweishengshi+""}</td>
        <td>{row.benkebizhenghao+""}</td>
        <td>{row.kaoshididian+""}</td>
        <td>{row.zhengzhimianmaoma+""}</td>
        <td>{row.zhengzhimianmao+""}</td>
        <td>{row.zaixiaoshengxuehao+""}</td>
        <td>{row.xuelima+""}</td>
        <td>{row.yuanxueli+""}</td>
        <td>{row.xueshizhengshuhao+""}</td>
        <td>{row.xueweima+""}</td>
        <td>{row.yuanxuewei+""}</td>
        <td>{row.luquleibiema+""}</td>
        <td>{row.luquleibie+""}</td>
        <td>{row.ruxuefangshima+""}</td>
        <td>{row.ruxuefangshi+""}</td>
        <td>{row.kaoshifangshima+""}</td>
        <td>{row.zibianzhuanyema+""}</td>
        <td>{row.zhuanyedaima+""}</td>
        <td>{row.zhuanyemingchen+""}</td>
        <td>{row.yanjiufangxiangma+""}</td>
        <td>{row.yanjiufangxiang+""}</td>
        <td>{row.baokaodanweima+""}</td>
        <td>{row.baokaodanwei+""}</td>
        <td>{row.dierzhiyuan+""}</td>
        <td>{row.dierzhiyuanma+""}</td>
        <td>{row.daoshibianhao+""}</td>
        <td>{row.daoshi+""}</td>
        <td>{row.daoshizhicheng+""}</td>
        <td>{row.xisuoma+""}</td>
        <td>{row.xisuo+""}</td>
        <td>{row.xueyuan+""}</td>
        <td>{row.waiguoyuma+""}</td>
        <td>{row.waiyu+""}</td>
        <td>{row.zhengzhililunma+""}</td>
        <td>{row.zhengzhi+""}</td>
        <td>{row.yewuke1ma+""}</td>
        <td>{row.yewuke1+""}</td>
        <td>{row.yewuke2ma+""}</td>
        <td>{row.yewuke2+""}</td>
        <td>{row.zhuanyefangxiang+""}</td>
        </tr>
        )
        }.bind(this))}
        </tbody>
        </table>
        </div>
        );
        }
        });

        var DislineComponent = React.createClass({
        getInitialState : function(){
        return ({data : []});
        },
        componentDidMount : function(){
        $.ajax({
        url : '/loadDisclineList',
        dataType : 'json',
        cache : false,
        success : function(disclineData){
            this.setState({data : disclineData});
        }.bind(this)
        });
        },
        componentDidUpdate : function(){
        $('#disclineTable').dataTable({
        "sPaginationType": "bootstrap",
        "bAutoWidth": false,
        "bDestroy": true,
        "fnDrawCallback": function() {
        //self.forceUpdate();
        }
        });
        var table = $('#disclineTable').dataTable();
        $('#disclineTable tbody').on( 'click', 'tr', function () {
        var selectTr = $(this)[0];
        var profession = selectTr.childNodes[1].firstChild.data;
        var induction = selectTr.childNodes[2].firstChild.data;
        var teachPlan = selectTr.childNodes[3].firstChild.data;
        var teachers = selectTr.childNodes[4].firstChild.data;
        var praticeBase = selectTr.childNodes[5].firstChild.data;

        React.render(<DisclineModalComponent name="disclineModal" profession={profession} induction={induction} teachers={teachers} teachPlan={teachPlan} praticeBase={praticeBase}/>,document.getElementById('disModal'));
        var modal = $('#disclineModal').modal('show');
        });
        },
        render : function(){
        return(
        <div class="table-responsive">
        <div id="disModal"></div>
        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="disclineTable">
        <thead>
        <tr>
        <th>编号</th>
        <th>专业方向</th>
        <th>方向介绍</th>
        <th>教学计划</th>
        <th>师资力量</th>
        <th>实习基地</th>
        <th>专业人数</th>
        </tr>
        </thead>
        <tbody>
        {this.state.data.map(function(row,index){
        return (
        <tr style={{cursor:'pointer'}}>
        <td>{index+1+""}</td>
        <td>{row.zhuanyefangxiang+""}</td>
        <td>{row.fangxiangjieshao+""}</td>
        <td>{row.jiaoxuejihua+""}</td>
        <td>{row.shizituandui+""}</td>
        <td>{row.shixijidi+""}</td>
        <td>{row.students.length+""}</td>
        </tr>
        )
        })}
        </tbody>
        </table>
        </div>
        );
        }
        });


        var UploadFileComponent = React.createClass({
        render : function(){
        return (
        <form method="POST" enctype="multipart/form-data" action="/uploadFile">
        File to upload: <input type="file" name="file" /><br />
        Name: <input type="text" name="name" /><br /> <br />
        <input type="submit" value="Upload" /> Press here to upload the file!
        </form>
        );
        }
        });


        function studentManager(){
        $('#disManagerButton').removeClass("active");
        $('#uploadFile').removeClass("active");
        $('#stuManagerButton').addClass("active");
        React.render(<StuComponent deleteFunction='deleteStudent'/>,document.getElementById('jquerydatatable'));
        }
        function disclineManager(){
        $('#stuManagerButton').removeClass("active");
        $('#uploadFile').removeClass("active");
        $('#disManagerButton').addClass("active");
        React.render(<DislineComponent/>,document.getElementById('jquerydatatable'));
        }
        function uploadFile(){
        $('#stuManagerButton').removeClass("active");
        $('#disManagerButton').removeClass("active");
        $('#uploadFile').addClass("active");
        React.render(<UploadFileComponent/>,document.getElementById('jquerydatatable'));
        }
        $(document).ready(function(){
        disclineManager();
        });
        </script>
        </body>
        </html>