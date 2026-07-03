<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" isErrorPage="true"%>
<%@ page language="java" import="gov.mof.fasp2.buscore.framework.util.GlobalConfig" %> 
<%@ page import="gov.mof.fasp2.pmkpi.randomComment.service.RandomService" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head lang="en">
    <meta charset="UTF-8">
    <title>抽取项目</title>
</head>
<link rel="stylesheet" href="css/extract-pro.css"/>

<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/darkblue/uistyle.css" />

<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_core.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_template.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js?<%=GlobalConfig.getVersionYear()%>"></script>
<script type="text/javascript">
	var _APPID_PATH_='/pmkpi';
	var _SETYEAR_='setyear=null';
    var _ROOT_PATH_='<%=(String)request.getContextPath()%>';
    var liststr = window.parent.document.getElementById('list').value;
    var list = liststr.split(',');
    var listsize = parseInt(window.parent.document.getElementById('listsize').value);
    var rantime = parseInt(window.parent.document.getElementById('rantime').value);
</script>
<head lang="en">
    <meta charset="UTF-8">
    <title>抽取项目</title>
    <link rel="stylesheet" href="css/extract-pro.css"/>
</head>
<body style="background-color:transparent">
<%
	String liststr = request.getParameter("list");
	String lists = java.net.URLDecoder.decode(liststr,"UTF-8");
	String[] list =lists.split(",");
 	pageContext.setAttribute("list",list); 
 %>
    <div class="pro-container">
        <div class="tit">
            <span class="star"></span>
            <h3 class="tit-con">
                项目抽取中
            </h3>
            <div class="result">
                <span class="text">已随机抽取项目数:</span>
                <div class="count" id='count'>
                    <span>0</span>
                    <span>0</span>
                    <span>0</span>
                    <span>0</span>
                    <span>0</span>
                    <span>0</span>
                </div>
            </div>
        </div>
        <div class="outer">
            <div class="pro-list" id="proList">
                <div class="inner-wrap" id='innerWrap'>
                    <ul>
                    <c:forEach items="${pageScope.list}" var="pro" varStatus="j">
                        <li>${pro}</li>
                    </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <div class="btn">
            <input type="button" value="确定" class="disabled" onclick="startScroll(this);" id='runBtn'/>
        </div>
    </div>
</body>
</html>
<script>
    //获取数字的各个位上的数字组成的数组
    var endNum=0;//最终要的数字！！！！！！
    var startBtnDisabled=true; //按钮是否禁用
    var btn=document.getElementById('runBtn');//操作按钮
    var timeId=null; 
    var originNum=0;//当前滚动到的数字
    var arr=[];
    var flagStart=true;
    $ChangeNum(1, listsize, rantime, 'count',flagStart);
    //点击确定按钮
    function startScroll(btn){
        if(startBtnDisabled){
          return;
        }else{
            flagStart=!flagStart;
            var el =window.parent.document.getElementById('tttt');
            el.style.display='none';
            parent.Ext.lt.HTML.unmark();
            parent.Ext.lt.pmkpi.query();
            // btn.value=flagStart?'确定':'开始'
            // $ChangeNum(1, 122, 5000, 'count',flagStart);
        }
    }
    function $ChangeNum(startNum, targetNum, time, selector,flag) {
        var dom = document.getElementById(selector);
        originNum= startNum>originNum?startNum:originNum;
        var timeNum = targetNum-startNum>1?time/(targetNum-startNum):time;
        if(flag){
            clearInterval(timeId);
            timeId = setInterval(function(){
                if (originNum < targetNum) {
                    originNum += 1;     
                } else {
                    startBtnDisabled=false;
                    //btn.classList.remove('disabled');
                    btn.removeAttribute('class','disabled');
                    clearInterval(timeId);
                    // originNum=1;
                }
                arr=getNumInf(originNum);
                var span=dom.getElementsByTagName('span');
                for(var i=0;i<span.length;i++){
                    span[i].innerText=arr[i];
                }
            }, timeNum);
        }else{
            var endNumArr=[];
            arr=getNumInf(originNum);
            for(var i=0;i<arr.length;i++){
                if(arr[arr.length-1-i]!='0'){
                    endNumArr.unshift(arr[arr.length-1-i]);
                }
            }
            endNum=Number(endNumArr.join(''));//最终要的数字！！！！！！
            console.log(endNum,"endNum");
            clearInterval(timeId);
        }
    };
    //获取数字的各个位上的数字组成的数组
    function getNumInf(num){
        var arr=['0','0','0','0','0','0'];
        var number =num
        number = number.toString() //把数bai字du转换zhi成dao字符zhuan串shu
        for (var i = 0; i < number.length; i++) {
            arr[i]=number[ number.length-1-i];
        }
        return arr.reverse();
    }
</script>

<script>
    //无缝滚动------------------------
    var n=0;//初始化scrollTop值
    var mytime;//存setInterval
    var mytime2;//存setTimeout
    var proList=document.getElementById('proList');
    
    var offsetHeightCont=document.getElementById('innerWrap').getElementsByTagName('ul')[0].offsetHeight;
    var offsetHeightProList=proList.offsetHeight;
    if(offsetHeightCont>offsetHeightProList){
        var ulList=document.getElementById('innerWrap').getElementsByTagName('ul')[0].cloneNode(true);
        document.getElementById('innerWrap').appendChild(ulList);
        function goTop(){
            if(n>=proList.scrollHeight/2){
                n=0;
                proList.scrollTop=n;
                stopGo();
                mytime2=setTimeout(startGo,2000);
            }else {
                n++;
                proList.scrollTop=n;
            }
        }
        function startGo(){
            mytime=setInterval(goTop,50);
        }
        startGo();
        function stopGo(){
            clearInterval(mytime);
            clearTimeout(mytime2); 
        }
        proList.onmouseover=stopGo;
        proList.onmouseout=startGo;
    }

</script>