if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.zjtempdata)
    Ext.lt.pmkpi.zjtempdata = {};
var serviceid;
var _code;
var isdatachage = false; //数据是否变动
var oldnodeid = ""; //上一次的树节点.
var _treeid;
var procodemap = {}; //key:agnecy,value 最大值，因为浙江有历史数据，暂不考虑同时录入一个单位项目的情况
var treenodecache = [];
Ext.lt.pmkpi.zjtempdata = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var
        _defquery,
        _isleaf,
        _levelno,
        _menuid = config["menuid"],
        _province = config["province"], //当前区划.
        _IS_HUBEI = config["IS_HUBEI"],
        _IS_SX = config["IS_SX"],
        _treeNode,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight,
    serviceid = service;

    $(function () {
        deptcmp.initDatatable();
    })

    cmp.query = function (){
        Ext.lt.pmkpi.query();
    }
    /**
     * 查询.
     */
    Ext.lt.pmkpi.query = function(){
        //获取选中的左侧树数据
        var params = {};
        if (!_treeid) {
            return;
        }
        oldnodeid = _treeid;
        params.treeid = _treeid;
        params.isleaf = _isleaf;
        params.tablesql = _defquery;
        params.querySql = queryform.getQuerySQL();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
            },function(){
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('查询失败！',function(){
                });
            });
    }
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });
    /**
     * 点击左侧树查询
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if (treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
            _levelno = treeNode.levelno;
            _treeNode = treeNode;
        } else {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        //判断表格是否有更新的数据
        if (isdatachage == true){
            Ext.lt.ui.confirm("数据尚未保存，是否离开？", {icon:"warn"}, function(flag) {
                if(!flag){
                    isdatachage = false;
                    treenodecache = datatable.getRecordSet().toArray();
                    lefttree.qtree.gotoNode(oldnodeid,true);
                }else{
                    cmp.query();
                    isdatachage = false;
                    treenodecache = [];
                }
            });
        } else {
            if (treenodecache && treenodecache.length !=0){
                for (let i = 0; i < treenodecache.length; i++) {
                    if (!treenodecache[i]["agencyguid"]){
                        treenodecache[i]["agencyguid"] = null;
                    }
                }
                datatable.setDatas(treenodecache);
                treenodecache = [];
            } else {
                cmp.query();
                isdatachage = false;
                treenodecache = [];
            }
        }
    });
    /**
     * 表格查询。
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });
    /**
     * 保存数据.
     */
    cmp.savemajorkey = function(){
        if(!datatable.checkAll())return;
        var params={};
        params.agency = _treeid;
        params.datas = datatable.getRecordSet().toArray();
        Ext.lt.RCP.call(serviceid, "savemajorkey", params, function(rs){
            if (rs && rs.success) {
                isdatachage = false;
                Ext.lt.ui.alert('保存成功！',function(){
                    cmp.query();
                });
            }
            Ext.lt.ui.loadingClose();
        }, function(){
            Ext.lt.ui.alert('保存失败！',function(){
            });
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("datatable", 'beforesetcols',function(data){
        var uiconfig = data.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var config = data.table.config;
        var cols = data.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="isadd"){
                col.fn = function(l,c,data,col){
                    var html = "";
                    if(_IS_HUBEI == true){ //湖北模式
                        if((data.proelement == "01" && (data.levelno == "2" || data.levelno == "1")) ||
                           (data.proelement == "02" && (data.levelno == "2" || data.levelno == "3"))){//层次
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "新增下级" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:zjtempdata.indexadd("'+data.guid+'","'+data.levelno+'","'+data.proelement+'","'+data.code+'")\'>新增下级</a>';
                        }
                        if (data["agencyguid"] && data["agencyguid"] == _treeid){
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:zjtempdata.indexdel("'+data.guid+'")\'>删除</a>';
                        }
                    }else if(_IS_SX == true){ //山西模式 自己维护共性指标的二级，个性指标的三级
                        if((data.levelno == "2" && data.proelement == "sx00") || (data.levelno == "3" && data.proelement == "sx01")){
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "新增下级" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:zjtempdata.indexadd("'+data.guid+'","'+data.levelno+'","'+data.proelement+'","'+data.code+'")\'>新增下级</a>';
                        }
                        if ((data.levelno == "3" && data.proelement == "sx00") || (data.levelno == "4" && data.proelement == "sx01")){
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:zjtempdata.indexdel("'+data.guid+'")\'>删除</a>';
                        }
                    }else {
                        if(data.levelno == "1" || data.levelno == "2"){//层次
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "新增下级" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:zjtempdata.indexadd("'+data.guid+'","'+data.levelno+'","'+data.proelement+'","'+data.code+'")\'>新增下级</a>';
                        }
                        if (data.code != "01"){
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:zjtempdata.indexdel("'+data.guid+'")\'>删除</a>';
                        }
                    }
                    return html;
                }
            }
            /*if (col["colcode"]=="agencyguid"){
                col.fn = function(l,c,data,col){
                    var  agencyguid = data["agencyguid"];
                    var returnstr = "";
                    if (agencyguid){
                        var node = lefttree.qtree.getData(agencyguid);
                        returnstr = node.name;
                    }
                    return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                }
            }*/
            if (col["colcode"]=="name"){ //只有二三级是可编辑的
                col.oneditstart = function (table, el, l, c, d) {
                    if (d["levelno"] == 1) {
                        return false;
                    }
                }
            }
        }
    });

    //导入一二级项目
    cmp.importProj = function(){
        var url = "/pmkpi/setting/zjtempdata/zjproImport.jsp";
        var params = {};
        var ishubei =  0;
        if(_IS_HUBEI == true){
            ishubei = 1;
        }
        params.is_hubei = ishubei;
        params.menuid = _menuid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,"800","450","码表项目导入");
    }
    //导出-- 暂时不用
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = '/pmkpi/setting/zjindexenum';
            cfg.bustable = datatable;
            if (data.size() == 0) {
                alert("请选择数据进行导出！");
                return;
            } else {
                cfg.downtype = 'xls';//下载  类型
                dataexport.excelexport(cfg);
            }
        } else {
            Ext.lt.ui.alert("页面无数据！", {timeout: 1}, function () {
            });
            return;
        }
    }

    /**
     * 删除项目
     * @param guid --项目的主键
     */
    cmp.indexdel = function (guid) {
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            for (var i = 0; i < datas.length; i++) {
                var selectDatas = datas[i];
                //如果有下级则不可删除
                if(guid ==selectDatas.superid){
                    Ext.lt.ui.alert('该数据有下级 不可删除！');
                    return;
                }
            }
        }
        if(_IS_HUBEI == true){ //单位可以展示部门录入的一级分类下扩展二级分类，去数据库校验是否有下级进行处理
            var params = {};
            params.superid = guid;
            var rs = Ext.lt.RCP.asyncall(serviceid , "isCanDelete", params);
            if (rs > 0){
                Ext.lt.ui.alert('下级单位已经扩展了下级，请删除下级单位此分类下的数据！');
                return;
            }
        }
        Ext.lt.ui.confirm("你确定删除选定的数据？", {icon: "warn"}, function (ret) {
            if (ret) {
                isdatachage = true;
                var datas = datatable.getRecordSet().toArray();
                if (datas != null && datas.length > 0) {
                    for (var i = 0; i < datas.length; i++) {
                        var selectDatas = datas[i];
                        if (guid == selectDatas.guid) {
                            datatable.removeData(selectDatas);
                        }
                    }
                }
            }
        });
    }

    /**
     * 新增下级项目
     * guid --行数据
     * levelno --- 层级编码
     * proelement -- 项目分类.
     * parentcode --父级编码
     */
    cmp.indexadd = function (guid, levelno, proelement, parentcode) {
        isdatachage = true;
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        var newdata ={};
        if (!procodemap[_treeid]){
            var params = {};
            params.agency = _treeid; //如果是部门的则按在***001上
            params.superid = guid; //父级项目的guid
            var code = Ext.lt.RCP.asyncall(serviceid , "getMaxcode", params);
            procodemap[_treeid] = code;
            newdata.code = _province+_treeid+code;
        } else {
            var i=Number(procodemap[_treeid]);
            i+=1;
            //处理左补0
            i= (Array(5).join(0) + i).slice(-5);
            newdata.code = _province+_treeid+i;
            procodemap[_treeid] = i;
        }
        if(_IS_SX == true){//山西编码规则：上级节点编码+排序序号
            var parent_sel_rows = datatable.getRecordset().query({superid:guid});
            var i = parent_sel_rows.length + 1;
            i= (Array(2).join(0) + i).slice(-2);
            newdata.code = parentcode + i;
        }
        newdata.agencyguid = _treeid;
        newdata.guid = newguid;
        newdata.ordernum = newdata["code"].substring(newdata["code"].length-5); //记录最大的排序
        newdata.proelement = proelement;
        newdata.levelno = Number(levelno)+1;
        newdata.superid = guid;
        newdata.rowtype = "add";
        if (datatable.getCol("agencyguid") && datatable.getCol("agencyguid")["isvisiable"] == 1) {
            var isadd_source= [];
            var temparr = [];
            temparr.push(_treeNode.guid);
            temparr.push(_treeNode.code);
            temparr.push(_treeNode.name);
            isadd_source.push(temparr);
            datatable.addMapperDatas("agencyguid", isadd_source);
        }
        datatable.getRecordSet().addData(newdata,999);
    }

    return cmp;
}