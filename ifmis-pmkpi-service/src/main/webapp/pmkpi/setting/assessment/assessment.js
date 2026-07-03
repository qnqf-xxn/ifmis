Ext.lt.pmkpi.assessmentservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var
            _tablecode,//表名
            _defquery,//表配置过滤条件
            _orderby//表排序sql
        ;
        var cmp = {};
        serviceid = service;
        /**
         *
         */
        Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
            var config = obj.config;
            _tablecode = obj.uiconfig.tablecode;
            _defquery = obj.uiconfig.defquery;
            _orderby = obj.uiconfig.orderby;
        });

        cmp.query = function(){
            var params = {};
            params.tablesql = _defquery;
            params.orderby = _orderby;
            params.tablecode = _tablecode;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
                datatable.setDatas(rs.data);
//                setTimeout(function(){
//                    amtTotal(datatable);
//                },100);
                Ext.lt.ui.loadingClose();
            },function(){
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('查询失败！',function(){
                });
            });
        }

        cmp.save = function(){
            if (!datatable.checkAll()) return false;//先校验
            var params = {};
            params.datas = datatable.getRecordSet().toArray();
            params.updatas = datatable.getUpdataData();
            params.deldatas = datatable.getRemoveData();
            params.tablecode = _tablecode;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "save", params, function(rs){
                    if(rs && rs.success == true){
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert('保存成功！',function(){
                            cmp.query();
//                            amtTotal(datatable);
                        });
                    }
                 },function(){
                    Ext.lt.ui.loadingClose();
                            Ext.lt.ui.alert('保存失败！',function(){
                    });
                 });

        }

        $(function () {
            common.initDatatable();
            cmp.query();
        })

        Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
            var cols = obj.cols;
            if(!Ext.lt.isArray(cols))
                cols = [cols];
            for(var i=0; i<cols.length; i++){
                var col = cols[i];
                if(col["colcode"]=="weight"){
                    col.fn = function(l,c,data,col){
                        if(data.isleaf == "0"){
                            var weight = 0;
                            if(data.weight){
                                weight = data.weight;
                            }
                            return "<b>"+Math.round(weight*100)/100+"</b>";
                        }else{
                            return data.weight ? data.weight : "";
                        }
                    }
//                    col.oneditend = function (table, el, l, c, d) {
//                        gatherWeight(d.superid);
//                        amtTotal(datatable);
//                    }
                }
                //一二级指标不可修改
                if(col["colcode"]=="points"){
                    col.oneditstart = function(table,el,l,c,d){
                        if(d.levelno != "2"){
                            return false;
                        }
                    }
                }
                if(col["colcode"]=="obligate"){
                        col.style = " text-align:center;";
                        col.fn = function(l,c,data,col){
                            var html = "";
                            if(data.levelno == "1"){
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'")\'>新增</a>';
                            }
//                             else if(data.levelno == "2"){
//                                html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'","'+data._locationposition+'","'+data.superid+'")\'>删除</a>';
//                            }
                            return html;
                        }
                }
            }
        });


        Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
                var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
                var newdata ={};
                newdata.guid = newguid;
                newdata.levelno = 1;
                newdata.isleaf = 0;
                newdata.superid = '00';
                newdata.rowtype = "add";
                datatable.getRecordSet().addData(newdata,999);
        });

        Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
                var datas = datatable.getRecordSet().toArray();
                var selDatas = datatable.getSelected();
                if (selDatas.size() <= 0) {
                    Ext.lt.ui.alert('请选择要删除的数据！',function(){
                    });
                    return;
                }
                Ext.lt.ui.confirm('是否删除已选择数据,删除父级会删除父级下所有数据？',null,function(is){
                    if(is){
                        for(var i=0; i<selDatas.length; i++){
                            var levelno = selDatas[i].levelno;
                            if(levelno == 1){
                                var guid = selDatas[i].guid;
                                for(var i=0; i<datas.length; i++){
                                    var superid = datas[i].superid;
                                    if(superid == guid){
                                       selDatas.push(datas[i]);
                                    }
                                }
                            }
                        }
                        datatable.removeData(selDatas);
//                        amtTotal(datatable);
                    }
                })
        });

        Ext.lt.pmkpi.addrow = function(data){
            datatable.getRecordSet().addData(data,999);
        }

        return cmp;
    }

    function indexadd(guid) {
        var data = {};
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        data.guid = newguid;
        data.rowtype = "add";
        data.superid = guid;
        data.levelno = 2;
        data.isleaf = 1;
        datatable.getRecordSet().addData(data,999);
    }

    function indexdel(guid,_locationposition,superid) {
        Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
            if(ret){
                var data = {};
                data.guid = guid;
                data._locationposition = _locationposition;
                datatable.removeData(data);
//                gatherWeight(superid);
            }
        });
    }

//    function gatherWeight(superid){
//        var datas = datatable.getRecordSet().toArray();
//        if(superid){
//            if(datas!=null && datas.length > 0){
//                var supguid = '';
//                var sortid = 0;
//                var result = 0;
//                var guid = '';
//                for(var i=0;i<datas.length;i++){
//                    var selectDatas = datas[i];
//                    if(superid == selectDatas.guid){
//                        supguid = selectDatas.superid;
//                        guid = selectDatas.guid;
//                    }
//                    if(selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)){
//                        result += parseFloat(selectDatas.weight);
//                    }
//                }
//                datas.each(function(data,i){
//                    if(data.guid == guid){
//                        datas[i]['weight'] = result==0 ? "" : result.toFixed(2);
//                    }
//                });
//                gatherWeight(supguid);
//            }
//        }
//        datatable.reflash();
//    }
//
//    function amtTotal(table) {
//        if(table.getSumobj()){
//            var totalrow = table.getRecordset();
//            var sumamt = 0;
//            var rowarr = totalrow.toArray();
//            var len = rowarr.length;
//            for ( var i = 0; i < len; i++) {
//                if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
//                    var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
//                    sumamt += parseFloat(weight);
//                } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
//                    var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
//                    sumamt += parseFloat(weight);
//                }
//            }
//            var totalrs = {};
//            totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
//            totalrs.datatable_do_sum=true;
//            table.getClockRowSet().setData(totalrs,0);
//            if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
//                table.reflashdata();
//            }
//        }
//    }