if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfself) {
    Ext.lt.pmkpi.perfself = {};
}
Ext.lt.pmkpi.perfself.perfselfrandomcheckservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
     var cmp = {};
     var _menuId = config.menuId,//菜单id
         _dept_code = config.dept_code,
         _tablecode,//列表查询表
         _defquery,//列表查询条件
         _tabfilter,//页签查询条件
         _tabcode,//页签编码
         _saveAgency,//左侧树选择单位
         _queryConfig, //查询区配置
         _querySql, //查询区条件
         _viewtype = config.viewtype;

     var isfirst = true;
    var _displaycols = [];

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (isfirst) {
            isfirst = false;
        }
        cmp.setTableColum();
        Ext.lt.pmkpi.query();
    })

     //查询
     cmp.query = function (){
         Ext.lt.pmkpi.query();
     }

     Ext.lt.pmkpi.query = function(){
         Ext.lt.ui.loadingShow();
         if (!_saveAgency) {
             _saveAgency = "treeroot";
             Ext.lt.pmkpi.isleaf = 0;
         }
         var params = {};
         params.queryConfig = _queryConfig;
         params.querySql = _querySql;
         params.tablecode = _tablecode;
         params.defquery = _defquery ;
         params.menuId = _menuId;
         params.tabcode = _tabcode;
         params.saveAgency = _saveAgency;
         params.tabfilter = _tabfilter;
         params.isleaf = Ext.lt.pmkpi.isleaf + "";
         params.type = "check";
         params.dept_code = _dept_code;
         params.beanid = "pmkpi.perfSelf.PerfSelfRandomBOTX";
         datatable.queryData(params,function(){
             Ext.lt.ui.loadingClose();
         });
     }

     Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
         var uiconfig = obj.table.uiconfig;
         _defquery = uiconfig.defquery;
         _tablecode = uiconfig.tablecode;
     });



     /**
     * 确认纳入
     */
     cmp.addrandom = function (btnobj){
         var datas = datatable.getSelected();
         if(!datas.length || datas.length <= 0 ){
             Ext.lt.ui.alert("请选择要纳入的项目！",function(){});
             return;
         }
         var params = {};
         params.datas = datas;
         params.tablecode = _tablecode;
         Ext.lt.ui.confirm('是否确认纳入所选项目？',{icon: "warn"},function(is){
             if(is){
                 Ext.lt.ui.loadingShow();
                 Ext.lt.RCP.call(service , "addrandom", params, function(rs){
                     if (rs && rs.success == true) {
                         Ext.lt.ui.alert('纳入成功！',function(){
                             Ext.lt.pmkpi.query();
                             window.parent.Ext.lt.pmkpi.query();
                         });
                         Ext.lt.ui.loadingClose();
                     }
                 },function(rt){
                     Ext.lt.ui.loadingClose();
                     Ext.lt.ui.alert('纳入失败：' + rt,function(){
                     });
                 });
             }
         })
     }

     /**
     * 取消纳入
     */
     cmp.delrandom = function (btnobj){
         var datas = datatable.getSelected();
         if(!datas.length || datas.length <= 0 ){
             Ext.lt.ui.alert("请选择要取消纳入的项目！",function(){});
             return;
         }

         var params = {};
         params.datas = datas;
         params.tablecode = _tablecode;
         Ext.lt.ui.confirm('是否确认取消纳入所选项目？', {icon: "warn"}, function(is){
             if(is){
                 Ext.lt.ui.loadingShow();
                 Ext.lt.RCP.call(service , "delrandom", params, function(rs){
                     if (rs && rs.success == true) {
                         Ext.lt.ui.alert('取消纳入成功！',function(){
                             Ext.lt.pmkpi.query();
                             window.parent.Ext.lt.pmkpi.query();
                         });
                         Ext.lt.ui.loadingClose();
                     }
                 },function(rt){
                     Ext.lt.ui.loadingClose();
                     Ext.lt.ui.alert('取消纳入失败：' + rt,function(){
                     });
                 });
             }
         })
     }

    /**
     * 页签
     */
    cmp.clickTabpage = function (obj){
        if(_viewtype == "query"){
            var buttons = toolbutton.cfg.data.buttons;
            for(var i=0,length = buttons.length;i<length;i++){
                var btn = buttons[i];
                toolbutton.hidden(btn.name);
            }
        } else {
            changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        }
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            cmp.setTableColum();
            Ext.lt.pmkpi.querytree();
            Ext.lt.pmkpi.query();
        }

    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuId = _menuId;
        params.tabcode = _tabcode;
        params.dept_code = _dept_code;
        params.tabfilter = _tabfilter;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
    }


    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        cmp.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        _queryConfig = queryform.getQueryParam();
        if(_queryConfig[0].ALL_COLUMNS) {
            _querySql = "";
        } else {
            _querySql = queryform.getQuerySQL();
        }
        Ext.lt.pmkpi.query();
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _tabcode) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.redraw();
    }

     return cmp;
}