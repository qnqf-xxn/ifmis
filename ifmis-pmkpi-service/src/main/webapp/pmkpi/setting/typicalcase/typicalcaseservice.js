if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.typicalcase)
    Ext.lt.pmkpi.typicalcase = {};

Ext.lt.pmkpi.typicalcase = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _nodeguid,
        _menuid = config.menuid,//菜单id
        _viewtype = config.viewtype,
        _tablecode,
        _wheresql,
        _orderby,
        _uikey,
        _deltables,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _leftsource,
        _code = config.code,
        _delcols = config.delcols,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight;
    var cmp = {};
    var serviceid = service;

    $(function () {
        commoncmp.initDatatable();
        tabChange(_lefttab);
    })

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _nodeguid = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var _leftconfig = eval('(' + obj.config + ')');
        _leftsource = _leftconfig.leftsource;
        if (_viewtype == "query") {
            _lefthidebtn += ',新增,修改,删除,授权共享,取消授权';
        }
        commoncmp.changTooltoolbuttontStatus(0,  _lefthidebtn);
        var treedatas = Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.tasktype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.leftsource = _leftsource;
        params.code = _code;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        if(!!_code){
            for(var i = 0;i<datalist.length;i++){
                if(datalist[i].code==_code){
                    _nodeguid = datalist[i].guid;
                    Ext.lt.pmkpi.isleaf =datalist[i].isleaf;
                    break;
                }
            }
        }
        return datalist;
    }

    Ext.lt.pmkpi.query = function(){
        if(!_nodeguid){
            _nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.nodeguid = _nodeguid;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _wheresql;
        params.orderby = _orderby;
        params.leftsource = _leftsource;
        params.viewtype = _viewtype;
        params.beanid = "pmkpi.typicalcase.TypicalCaseBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    cmp.query = function(){
        Ext.lt.pmkpi.query();
    }
    /**
     * 查询消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _wheresql = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        var config = obj.config;
        _uikey = config.uikey;
        _deltables = config.deltables;
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "createtime") {
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var createtime = !val ? "" : val;
                    return createtime.substr(0,4)+"-"+createtime.substr(4,2)+"-"+createtime.substr(6,2);
                }
            }
        }
    });

    /**
     * 新增
     */
    cmp.add = function(){
        if(!_nodeguid || _nodeguid == "treeroot" || Ext.lt.pmkpi.isleaf != "1"){
            Ext.lt.ui.alert("请选择左侧树末级节点数据！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.mainguid = newguid;
        params.casetype = _nodeguid;
        params.pageurl = _uikey; //弹出的url.x
        params.viewtype = "add";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"典型案例库新增");
    }

    /**
     *修改
     */
    cmp.update = function(){
        var selDatas = datatable.getSelected();
        if (selDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条数据修改！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        params.mainguid = selDatas[0].guid;
        params.taskprovince = selDatas[0].province;
        params.taskyear = selDatas[0].year;
        params.casetype = _nodeguid;
        params.pageurl = _uikey; //弹出的url.
        params.viewtype = "mod";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"典型案例库修改");
    }

    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var selDatas = datatable.getSelected();
        if (selDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条数据！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        params.mainguid = selDatas[0].guid;
        params.taskprovince = selDatas[0].province;
        params.taskyear = selDatas[0].year;
        params.casetype = _nodeguid;
        params.pageurl = _uikey; //弹出的url.
        params.viewtype = "query";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"典型案例库详情");
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.tablecode = _tablecode;
        params.delcols = _delcols;
        params.deltables = _deltables;
        commoncmp.deltable(datatable, params);
    }

    /**
     *授权
     */
    cmp.auth = function(obj){
        obj.status = '1'
        cmp.doauth(obj);
    }

    /**
     *取消授权
     */
    cmp.cancelauth = function(obj){
        obj.status = '0'
        cmp.doauth(obj);
    }

    cmp.doauth = function (obj){
        var selDatas = datatable.getSelected();
        if (selDatas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！", function () {
            });
            return;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = selDatas;
        params.status = obj.status;
        Ext.lt.RCP.call(service , "auth", params, function(rs) {
            Ext.lt.ui.alert(obj.name +'成功！',function(){
                Ext.lt.pmkpi.query();
            });
            Ext.lt.ui.loadingClose();
        }, function(rt) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('操作失败：' + rt,function(){
            });
        });
    }

    /**
     * 左侧树点击事件
     */
    Ext.lt.message.hook("left", "click",function(obj){
        if(!_code){
            var treeNode = obj.node.data;
            if(treeNode){
                _nodeguid = treeNode.guid;
                Ext.lt.pmkpi.isleaf = treeNode.isleaf;
            } else {
                _nodeguid = "treeroot";
                Ext.lt.pmkpi.isleaf = '0';
            }
        }
        cmp.query();
    });
    return cmp;
}