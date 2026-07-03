if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.impexpsub)
    Ext.lt.pmkpi.impexpsube = {};

Ext.lt.pmkpi.impexpsub = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _tablecode,//表名
        _leftcode = config.leftcode,
        _delcols,
        _updatecols,
        _lefttablecode,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight,
        _defquery,//页签过滤条件
        _typeName,
        _colTablecode,
        _querycode,
        _columncodes,
        _treeCode,//左侧树对应字段tablecode
        _treeGuid;

    $(function () {
        common.initDatatable(uidatatable);
    })

    /**
     * 列配置
     */
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _delcols = config.delcols;
        _updatecols = config.updatecols;
        _lefttablecode=config.lefttablecode;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var cols = obj.cols;
        var sourcemap = new Map();
        var _framesdatas;//左侧树配置表表字段
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "columncode") {
                col.fn = function (l, c, data, col) {
                    if (data.columncode) {
                        return "<font style=\"margin-left:10px;\">" + data.columncode + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //判断表名是否存在，存在下拉，不存在文本
                    //存在表名，已选择字段去掉
                    if (_colTablecode && _colTablecode != "dual") {
                        if (_treeCode != _querycode) {
                            _querycode = _treeCode;
                            var params = {};
                            params.colTablecode = _colTablecode;
                            var rs = Ext.lt.RCP.asyncall(service, "getCol", params);
                            _framesdatas = rs.data;
                        }
                        if (_framesdatas && _framesdatas.length > 0) {
                            //查询剩余未配置字段
                            var columncodes = getColumns(_framesdatas);
                            table.getCol(c).format = '#code-#name';
                            Ext.lt.pmkpi.doMapper(columncodes, table.getCol(c));
                            for (var i = 0; i < columncodes.length; i++) {
                                sourcemap.set(columncodes[i].columncode, columncodes[i].name)
                            }
                            this.config.isMulti = false;
                        }
                    } else {
                        el.innerText = d.columncode != undefined ? d.columncode : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                        // return;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (_colTablecode && _colTablecode != "dual") {
                        var columncode = d.columncode;
                        d.columncode = columncode;
                        var columnname = sourcemap.get("" + columncode + "");
                        if(columnname) {
                            d.name = columnname;
                        }
                    }
                    sourcemap.clear();
                }
            }
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    /**
     * 保存
     */
    cmp.savemajorkey = function(){
        if(!uidatatable.checkAll())return;
        Ext.lt.ui.loadingShow();
        var params={};
        params.tablecode = _tablecode;
        params.treecode = _treeCode;
        params.delcols = _delcols;
        params.updatecols =_updatecols;
        params.datas = uidatatable.getRecordSet().toArray();
        params.deldatas = uidatatable.getRemoveData();
        Ext.lt.RCP.call(serviceid, "savemajorkey", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    Ext.lt.ui.loadingClose();
                    cmp.query();
                });
            }
        }, function(){
            Ext.lt.ui.alert('保存失败！',function(){
                Ext.lt.ui.loadingClose();
            });
        });
    }

    /**
     * 查询
     */
    cmp.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        if(_treeCode && _treeCode != "treeroot"){
            params.tablesql = " "+_leftcode+"= '" + _treeCode + "'";
        }
        params.querySql = queryform.getQuerySQL();
        params.beanid = "pmkpi.setting.impexpsub.PerfTImpexpsubBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        uidatatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 表格添加行
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newguid = Ext.lt.RCP.asyncall(serviceid, "getCreateguid", null);
        var newdata = {};
        newdata.guid = newguid;
        newdata.rowtype = "add";
        newdata.colwidth = 100;
        uidatatable.getRecordSet().addData(newdata, 100);
    });

    /**
     * 表格删除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var selDatas = uidatatable.getSelected();
        if(selDatas.size() <= 0){
            Ext.lt.ui.alert('请选择要删除的数据！', function(){});
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择的数据!', null, function(is){
            if(is){
                uidatatable.removeData(selDatas);
            }
        });
    });
    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode && treeNode.code && _treeCode != treeNode.code){
            _treeGuid = treeNode.guid;
            _typeName = treeNode.name;
            _treeCode = treeNode.code;
            _colTablecode = treeNode.superguid;
            cmp.query();
        }
    });
    /**
     * 初始化数据
     * @param params
     */
    cmp.initset = function(){
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.msg = "初始化";
        Ext.lt.RCP.call(serviceid , "initset", params, function(rs){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '成功！',function(){
                location.reload();
            });
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(params.msg + '失败！',function(){
            });
        });
    }

    /**
     * 新增頁
     */
    cmp.addleft = function (){
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.viewtype = "add";
        newdata.tablecode = _lefttablecode;
        var url = "/pmkpi/setting/impexp/impexpmianedit.page";
        url = Ext.lt.pmkpi.genPageUrl(url, newdata);
        Ext.lt.ui.openModalWindow(url,_scrWidth*0.75, _scrHeight*0.75,"新增模板类型");
    }

    /**
     * 修改頁
     */
    cmp.editleft = function (){
        if(_treeGuid==undefined||_treeGuid==""||_treeGuid==null){
            Ext.lt.ui.alert("请选择要修改的数据！",function(){});
            return;
        }
        var newdata ={};
        newdata.guid = _treeGuid;
        newdata.viewtype = "mod";
        newdata.tablecode = _lefttablecode;
        var url = "/pmkpi/setting/impexp/impexpmianedit.page";
        url = Ext.lt.pmkpi.genPageUrl(url, newdata);
        Ext.lt.ui.openModalWindow(url,_scrWidth*0.75, _scrHeight*0.75,"编辑模板类型");
    }

    /**
     * 删除
     */
    cmp.delleft = function () {
        if(_treeGuid==undefined||_treeGuid==""||_treeGuid==null){
            Ext.lt.ui.alert("请选择删除数据！",function(){});
            return;
        }
        var params ={};
        params.tablecode = _tablecode;
        params.guid = _treeGuid;
        params.treecode = _treeCode;
        params.lefttablecode=_lefttablecode;
        Ext.lt.ui.confirm('是否删除模板名称为'+_typeName+'的数据以及配置数据？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "del", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！',function(){
                        location.reload();
                        cmp.query();
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    //去除已选择的字段
    function getColumns(columns) {
        var datas = uidatatable.getRecordSet().toArray();
        var newList = [];  //保存遍历时要留下的项
        for(var j = 0; j < columns.length; j++){
            var columncode = columns[j].columncode;
            var isExist = false;
            for(var len = 0; len < datas.length;len++){
                var item = datas[len];
                if(item.columncode && item.columncode == columncode){
                    isExist = true;
                    break;
                }
            }
            if(!isExist){
                newList.push(columns[j]);
            }
        }
        return newList;
    }

    return cmp;
}

