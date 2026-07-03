if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}

/**
 * url拼接
 * @param url --url
 * @param paras --参数
 * @returns {string}
 */
Ext.lt.pmkpi.genPageUrl = function(url,paras){
    if(!url){
        return;
    }
    url = encodeURI(url);
    if(url.indexOf("tokenid")==-1){
        if(url.indexOf("?")==-1){
            url = url+"?tokenid=" + Ext.lt.token.getTokenid();
        }else{
            url = url+"&tokenid="+ Ext.lt.token.getTokenid();
        }
    }
    if(paras){
        var urlp = [];
        var key;
        for(key in paras){
            if(paras[key]||paras[key]===0){
                urlp.push("&");
                urlp.push(key);
                urlp.push("=");
                urlp.push(encodeURIComponent(paras[key]));
            }
        }
        url = url + urlp.join("");
    }
    var urlobj = {};
    urlobj.url = url;
    return urlobj.url;
}

Ext.lt.ui.isScrollY = function(obj) {
    if ((obj.scrollHeight-15) > obj.clientHeight || obj.offsetHeight > obj.clientHeight) {
        return true;
    }
    return false;
}

Ext.lt.ui.isScrollX = function(obj) {
    if ((obj.scrollWidth-15) > obj.clientWidth || obj.offsetWidth > obj.clientWidth) {
        return true;
    }
    return false;
}

//隐藏按钮事件
function changToolbuttonStatus (btnobj,index,hidebtns){
    var buttons = btnobj.cfg.data.buttons;
    for(var i=0,length = buttons.length;i<length;i++){
        var btn = buttons[i];
        //修改为隐藏显示
        if((","+hidebtns+",").indexOf(","+btn.name+",") != -1){
            document.getElementById(btn.name).style.display = "none";
            btn.isvisiable = 0;
        }else{
            document.getElementById(btn.name).style.display = "block";
            btn.isvisiable = 1;
        }
    }
}

/**
 * 只能输入数字校验
 * @param referencepole
 * @returns {boolean}
 */
function checkReferencepole (str){
    var re = /^\d*\.?(\d*)$/;
    // var re = /^(-?\d+)\.?(\d*)$/;//支持录入负数，不启用
    if(!re.test(str)){
        Ext.lt.ui.alert("定量指标的指标值为数值！");
        return false;
    }else{
        return true;
    }
}

/**
 * 生成32位guid.
 */
var createUUID = (function(uuidRegEx, uuidReplacer) {
	return function() {
		return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(uuidRegEx,
				uuidReplacer).toUpperCase();
	};
})(/[xy]/g, function(c) {
	var r = Math.random() * 16 | 0, v = c == "x" ? r : (r & 3 | 8);
	return v.toString(16);
});

/**
 * java服务生成32位随机guid.
 */
function getCreateguid(serviceid){
        var  itemid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        if(itemid==null || itemid ==""){
            itemid =  createUUID().replace(/-/g, '');
        }
    return itemid;
}

/**
 * 特殊字替换
 * @param remark
 * @returns {*}
 */
function convertStr (remark) {
    if (remark == null || remark === ""){
        return "";
    }
    /*
    为 全角
    \>
    \<
    \;
    \& 和号
    \'单引号
    \" 双引号
    \% 百分号
    \# #号
    */
    if(Object.prototype.toString.call(remark) === '[object String]'){
        remark =remark.replace("\\","＼");
        var  s= "/,>,<,;,&,',\",%,#,:,\\?,\\[,\\]";
        var  n= "／,》,《,；,＆,‘,“,％,＃,：,？,【,】" ;
        var sArray = s.split(",");
        var nArray = n.split(",") ;

        for (var i = 0 ;i<sArray.length;i++){
            var reg = new RegExp(sArray[i],"g") ;
            remark = remark.replace( reg,nArray[i]) ;
        }
        remark = replaceGBKPoint(remark);
    }
    return remark ;
}

/**
 * 空格校验
 * @param str 校验的字符串
 * @param name 提示字段名--`${name} 录入内容不得含有空格！`
 */
function checkSpaceStr(str, name) {
    if (!str) {
        return null;
    }
    var checkedStr = String(str);
    if ('null' === checkedStr){
        return name + '录入内容不能为"null"！';
    } else if ('NULL' === checkedStr) {
        return name + '录入内容不能为"NULL"！';
    } else {
        var spaceRegex = /[ 　]/;// 匹配全角/半角空格
        return spaceRegex.test(checkedStr) ? name + '录入内容不得含有空格！' : null;
    }
}

function replaceGBKPoint(remark){
    var oRemark = "";
    for (var i = 0 ;remark!=null&&i<remark.length;i++){
        var code = remark.charCodeAt(i);
        var c = remark.charAt(i);
        if(code==8226){
            oRemark += '·';
        }else{
            oRemark += c;
        }
    }
    return oRemark;
}

//提取url参数中得值 如: 当前url querystring:a=1   调用getUrlParam('a')返回1;
function getUrlParam(val,url){
    var uri = url||window.location.search;
    uri = decodeURIComponent(uri);
    var re = new RegExp("(\\?|&)" +val+ "\=([^\&\?]*)", "ig");
    return ((uri.match(re))?(uri.match(re)[0].substr(val.length+2)):null);
}

/**
 * 判断是否为字符串类型
 * @param str
 * @returns {boolean}
 */
function isString(str){
    return (typeof str=='string') && str.constructor==String;
}

/**
 * 判断是否为数组类型
 * @param obj
 * @returns {boolean}
 */
function isArray(obj){
    return (typeof obj=='object') && obj.constructor==Array;
}

/**
 * 判断是否为数值类型
 * @param obj
 * @returns {boolean}
 */
function isNumber(obj){
    return (typeof obj=='number') && obj.constructor==Number;
}

/**
 * 判断是否为日期类型
 * @param obj
 * @returns {boolean}
 */
function isDate(obj){
    return (typeof obj=='object') && obj.constructor==Date;
}

/**
 * 判断是否为函数
 * @param obj
 * @returns {boolean}
 */
function isFunction(obj){
    return (typeof obj=='function') && obj.constructor==Function;
}

/**
 * 判断是否为对象
 * @param obj
 * @returns {boolean}
 */
function isObject(obj){
    return (typeof obj=='object') && obj.constructor==Object;
}

/**
 * 解决两个数相加精度丢失问题
 * @param a
 * @param b
 * @returns {Number}
 */
function floatAdd(a, b) {
    var c, d, e;
    if(undefined==a||null==a||""==a||isNaN(a)){a=0;}
    if(undefined==b||null==b||""==b||isNaN(b)){b=0;}
    try {
        c = a.toString().split(".")[1].length;
    } catch (f) {
        c = 0;
    }
    try {
        d = b.toString().split(".")[1].length;
    } catch (f) {
        d = 0;
    }
    e = Math.pow(10, Math.max(c, d));
    return  (floatMul(a, e) + floatMul(b, e)) / e;
}
/**
 * 解决两个数相减精度丢失问题
 * @param a
 * @param b
 * @returns {Number}
 */
function floatSub(a, b) {
    var c, d, e;
    if(undefined==a||null==a||""==a||isNaN(a)){a=0;}
    if(undefined==b||null==b||""==b||isNaN(b)){b=0;}
    try {
        c = a.toString().split(".")[1].length;
    } catch (f) {
        c = 0;
    }
    try {
        d = b.toString().split(".")[1].length;
    } catch (f) {
        d = 0;
    }
    e = Math.pow(10, Math.max(c, d));
    return (floatMul(a, e) - floatMul(b, e)) / e;
}
/**
 * 解决两个数相乘精度丢失问题
 * @param a
 * @param b
 * @returns {Number}
 */
function floatMul(a, b) {
    var c = 0,
        d = a.toString(),
        e = b.toString();
    try {
        c += d.split(".")[1].length;
    } catch (f) {}
    try {
        c += e.split(".")[1].length;
    } catch (f) {}
    return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
}
/**
 * 解决两个数相除精度丢失问题
 * @param a
 * @param b
 * @param num 小数位数
 * @returns
 */
function floatDiv(a, b, num) {
    var c, d, e = 0,
        f = 0;
    try {
        e = a.toString().split(".")[1].length;
    } catch (g) {}
    try {
        f = b.toString().split(".")[1].length;
    } catch (g) {}
    c = Number(a.toString().replace(".", ""));
    d = Number(b.toString().replace(".", ""));
    if (d == 0) {
        return 0;
    }
    if (num) {
        return (floatMul(c / d, Math.pow(10, f - e))).toFixed(num);
    } else {
        return floatMul(c / d, Math.pow(10, f - e))
    }
}

/**
 * 校验结束时间大于开始时间
 * @param str1 开始时间
 * @param str2 结束时间
 */
function fnCheckDate(str1,str2){
    var startDate = new Date(str1.replace(/-/g,"/"));
    var endDate = new Date(str2.replace(/-/g,"/"));
    if(startDate > endDate){
        Ext.lt.ui.alert("【结束时间】不能小于【" + str1 + "】",function(){
        });
        return false;
    }
    return true;
}

/**
 * 动态改变列的属性.
 * @param rs
 * @param col
 */
Ext.lt.pmkpi.doMapper = function (rs, col) {
    var mapping = [];
    var columns = [];
    for (var i = 0; i < rs.size(); i++) {
        var arr = [];
        arr.push(rs[i].guid);
        arr.push(rs[i].code);
        arr.push(rs[i].name);
        columns.push(arr);
        mapping[rs[i].code] = arr;
    }
    col.mapping = mapping;
    col.mapper = {};
    col.mapper.columns = ['guid', 'code', 'name', 'supcode', 'pinyin'];
    col.mapper.datas = columns;
    col.mapper.regs = ['#guid', '#code', '#name', '#supcode', '#pinyin'];
    col.mapper.default_column = 'code';
    if (!col.format) {
        col.format = '#name';
    }
}

/**
 * 设置暂存状态和按钮隐藏显示
 * @param rs 返回结果集
 */
function setMidSaveHidButtons(rs){
    var hidButtons = rs.hidButtons;
    var btnobj;
    var btnobj2;
    var toolbtn;
    try {
        if (rs.isparent) {
            toolbtn = toolbutton;
            btndatas = toolbutton.cfg.data.buttons;
        } else {
            toolbtn = parent.toolbutton;
            btndatas = parent.toolbutton.cfg.data.buttons;
        }
    } catch (e) {
    }
    if (toolbtn && btndatas.length > 0) {
        for(var i=0,length = btndatas.length;i<length;i++) {
            var btn = btndatas[i];
            //修改为隐藏显示
            if(btn.name == "暂存"){
                btnobj = btn;
            }
            if(btn.name == "清除暂存"){
                btnobj2 = btn;
            }
        }
        if("暂存" == hidButtons && btnobj){
            toolbtn.hidden(btnobj.name); // 隐藏按钮
            toolbtn.hidden(btnobj2.name); // 隐藏按钮
            btnobj.isvisiable = 0;
            btnobj2.isvisiable = 0;
            if (rs.isparent) {
                _issavetmp = false;
            } else {
                parent._issavetmp = false;
            }
        }else if(btnobj){
            toolbtn.unHidden(btnobj.name); // 隐藏按钮
            toolbtn.unHidden(btnobj2.name); // 隐藏按钮
            btnobj.isvisiable = 1;
            btnobj2.isvisiable = 1;
            if (rs.isparent) {
                _issavetmp = true;
            } else {
                parent._issavetmp = true;
            }
        }
    } else {
        if(parent.$("#暂存").length > 0) {
            btnobj = parent.toolbutton;
            btnobj2 = parent.$("#清除暂存");
        } else if ($("#暂存").length > 0) {
            btnobj = $("#暂存");
            btnobj2 = $("#清除暂存");
        }
        if("暂存" == hidButtons && btnobj){
            btnobj.hide(); // 隐藏按钮
            btnobj2.hide(); // 隐藏按钮
            parent._issavetmp = false;
        }else if(btnobj){
            btnobj.show();
            btnobj2.show();
            parent._issavetmp = true;
        }
    }
    if($(".winfooter").children().length)$(".winfooter").children().first().css("width","100%");
    if(parent.$(".winfooter").children().length)parent.$(".winfooter").children().first().css("width","100%");
}

/**
 * 获取url参数
 * @param url
 * @returns {{}}
 */
function getAllUrlParams(url) {
    // 获取URL中的查询字符串
    var queryString = url ? url.split('?')[1] : window.location.search.slice(1);
    // 解析查询字符串并返回一个对象
    var obj = {};
    if (queryString) {
        queryString = queryString.split('#')[0]; // 去除URL中的hash
        var arr = queryString.split('&');
        for (var i = 0; i < arr.length; i++) {
            var a = arr[i].split('=');
            var paramName = a[0];
            var paramValue = a[1];
            paramValue = paramValue ? decodeURIComponent(paramValue.replace(/\+/g, ' ')) : undefined;
            var paramNum = undefined;
            try {
                paramNum = /[0-9]+/.exec(paramName)[0];
                paramName = paramName.replace(/\[\d+\]/, '');
            }
            catch (e) { }
            // 如果参数名已经存在，则转化为数组
            if (obj[paramName]) {
                if (typeof obj[paramName] === 'string') {
                    obj[paramName] = [obj[paramName]];
                }
                if (paramNum) {
                    obj[paramName].push(paramValue);
                }
                else {
                    obj[paramName].push(paramValue);
                }
            }
            else { // 如果不存在，直接赋值
                obj[paramName] = paramNum ? [paramValue] : paramValue;
            }
        }
    }
    return obj;
}

/**
 * 用于表格组件col.cseditfn内更新样式
 * @param styleString 原样式 col.cseditfn得style
 * @param propertiesToAdd 新样式，比如：'color:#FF0000'
 * @returns {string|*}
 */
function updateStyle(styleString, propertiesToAdd) {
    var styleContent = styleString.match(/style="([^"]*)"/);
    if (styleContent) {
        var currentStyles = styleContent[1];
        currentStyles = currentStyles.replace(/;\s*$/, '');
        var newStyles = currentStyles + '; ' + propertiesToAdd;
        return ' style="' + newStyles + '"';
    }
    return styleString;
}

/**
 * 新增绩效提示信息方法，通过提示语义控制调用下述不同的方法：
 * 1.successAlert
 * 2.tipAlert
 * 3.warnAlert
 * 4.errorAlert
 * @param str 提示词内容
 * @param cfg 配置，兼容老ui自定义内容 {}
 * @param callbakfn 回调
 */
Ext.lt.pmkpi.alert = function (str,cfg,callbakfn) {
    // 1. 参数解析
    var args = [];
    for (var i = 0; i < arguments.length; i++) {
        args.push(arguments[i]);
    }
    var callback = null;
    var message = str;
    // 2. 提取回调和消息
    for (var i = 0; i < args.length; i++) {
        var arg = args[i];
        var type = Object.prototype.toString.call(arg).slice(8, -1);
        if (type === 'String') {
            message = arg;
        } else if (type === 'Function') {
            callback = arg;
        } else if (type === 'Object') {
            if (arg.callbakfn) callback = arg.callbakfn;
            if (arg.message) message = arg.message;
        }
    }
    if (isGreyStyle()) {
        var alertMap = [
            { keywords: ["成功", "完成"], handler: successAlert },
            { keywords: ["失败", "错误", "异常"], handler: errorAlert },
            { keywords: ["警告", "注意", "重试", "无法", "不能", "禁止", "删除", "缺失"], handler: warnAlert }
        ];
        var matched = false;
        // 遍历关键词
        for (var j = 0; j < alertMap.length; j++) {
            var item = alertMap[j];
            var keywords = item.keywords;
            // 检查关键词
            for (var k = 0; k < keywords.length; k++) {
                if (message.indexOf(keywords[k]) !== -1) {
                    item.handler(message, callback);
                    matched = true;
                    return; // 匹配后立即返回
                }
            }
        }
        if (!matched) tipAlert(message, callback);
    } else {
        Ext.lt.ui.alert(str,cfg,callback);
    }
};

function getPointNum(num) {
    var str = String(num);
    var index = str.split(".");
    var str1 = null;
    if (index.length == 2) {
        str1 = index[1].substring(0, 2);
        str1 = Number(index[0] + "." + str1);
    } else {
        str1 = Number(index[0]);
    }
    return str1;
}

/**
 * 权重校验方法 二级有设置权重则校验，无则校验一级权重设定值
 * @param table 列表对象
 * @param _weight_sum 权重总和
 * @param checkweightcol 设定权重列
 * @param actualweightcol 实际权重列
 * @param fromsource 调用来源 prjindex crossjsp adjindex
 * @param _isCheckWeightGtZero 是否校验指标权重大于0:1-是，其它-否；
 * @returns {boolean}
 */
Ext.lt.pmkpi.weightCheckNew = function (table, _weight_sum, checkweightcol, actualweightcol, fromsource, _isCheckWeightGtZero) {
    if (!table) {
        table = datatable;
    }
    var checkweightcol = checkweightcol || "weight";
    var actualweightcol = actualweightcol || "actualweight";
    var _actualweightname = table.getCol(actualweightcol).alias;
    var levelnotMap = { "1": "一" , "2": "二" , "3": "三"};
    var flag = true;
    var datas = table.getRecordSet().toArray();
    if (datas != null && datas.length > 0) {
        var result = 0;
        var checkweight = 0;
        var index = "";
        var oldindex = "";
        var weightsum = 0;
        var indexname = "";
        var j = 1;
        for (var i = 0; i < datas.length; i++) { //校验二级指标
            var tempObj = datas[i];
            var levelno = tempObj.levelno;
            var actualweight = tempObj[actualweightcol] ?  getPointNum(parseFloat(tempObj[actualweightcol])) : 0.00;//权重
            if(levelno == "3" && (fromsource != "adjindex" || (fromsource == "adjindex" && tempObj.status!="1")) && _isCheckWeightGtZero == "1" && actualweight <= 0){
                var msg = "第" + j + "行【" + _actualweightname + "】值需大于0！";
                if (fromsource == "crossjsp"){
                    return "{callsuc:0,callmsg:'" + msg + "'}";
                }else{
                    Ext.lt.pmkpi.alert(msg, {timeout: 1}, function () { });
                    return false;
                }
            }
            if (levelno == "2") {
                index = tempObj.guid;
                if (oldindex == "") {
                    oldindex = index;
                    indexname = tempObj.name;
                    checkweight = !tempObj[checkweightcol] ? 0 : tempObj[checkweightcol];
                }
            }
            if (levelno == "3" && (fromsource != "adjindex" || (fromsource == "adjindex" && tempObj.status!="1"))) {
                if (actualweight) {
                    result = floatAdd(result, actualweight);
                }
            }
            if (index != oldindex || i == datas.length-1) {
                if(checkweight != result && checkweight != 0){
                    if(i == datas.length-1){
                        levelno = "2";
                    }
                    var msg = levelnotMap[levelno] + "级指标【" + indexname + "】的下级指标" + _actualweightname + "录入合计应等于上级设置数！";
                    if (fromsource == "crossjsp"){
                        return "{callsuc:0,callmsg:'" + msg + "'}";
                    }else{
                        Ext.lt.pmkpi.alert(msg, {timeout: 1}, function () { });
                        return false;
                    }
                }
                result = 0;
                oldindex = index;
                indexname = tempObj.name;
                checkweight = !tempObj[checkweightcol] ? 0 : tempObj[checkweightcol];
            }
            j++;
        }
        result = 0;
        checkweight = 0;
        index = "";
        oldindex = "";
        indexname = "";
        for (var i = 0; i < datas.length; i++) { //校验一级指标
            var tempObj = datas[i];
            var levelno = tempObj.levelno;
            var actualweight = tempObj[actualweightcol];//权重
            if (levelno == "1") {
                index = tempObj.guid;
                if (oldindex == "") {
                    oldindex = index;
                    indexname = tempObj.name;
                    checkweight = !tempObj[checkweightcol] ? 0 : tempObj[checkweightcol];
                }
            }
            if (levelno == "3" && (fromsource != "adjindex" || (fromsource == "adjindex" && tempObj.status!="1"))) {
                if (actualweight) {
                    result = floatAdd(result, actualweight);
                    weightsum = floatAdd(weightsum, actualweight);
                }
            }
            if (index != oldindex || i == datas.length-1) {
                if(checkweight != result){
                    if(i == datas.length-1){
                        levelno = "1";
                    }
                    var msg = levelnotMap[levelno] + "级指标【" + indexname + "】的下级指标" + _actualweightname + "录入应等于上级设置数！";
                    if (fromsource == "crossjsp"){
                        return "{callsuc:0,callmsg:'" + msg + "'}";
                    }else{
                        Ext.lt.pmkpi.alert(msg, {timeout: 1}, function () { });
                        return false;
                    }
                }
                result = 0;
                oldindex = index;
                indexname = tempObj.name;
                checkweight = !tempObj[checkweightcol] ? 0 : tempObj[checkweightcol];
            }
        }
        weightsum = weightsum.toFixed(2);
        if(_weight_sum && weightsum != _weight_sum){ // 汇总三级不得大于九十
            var msg = "权重设定值合计为：" + weightsum + ", 总和应等于" + _weight_sum + "！";
            if (fromsource == "crossjsp"){
                return "{callsuc:0,callmsg:'" + msg + "'}";
            }else{
                Ext.lt.pmkpi.alert(msg, {timeout: 1}, function () { });
                return false;
            }
        }
    }
    if (fromsource == "crossjsp"){
        return "success";
    }else{
        return flag;
    }
}