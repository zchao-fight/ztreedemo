<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>


<!DOCTYPE HTML>
<html>
<head>
    <link rel="stylesheet" href="${ctx}/css/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx}/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.ztree.all.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.ztree.exedit.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.ztree.exhide.js"></script>
</head>
<body>

<div>
    <ul id="treeDemo" class="ztree"></ul>
    <ul id="treeDemo2" class="ztree"></ul>
    <input type="button" value="保存" onclick="save()"/>
    <input type="button" value="显示" onclick="show()">
</div>

<script>


    var setting = {
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                rootPId: 0
            }
        },
        callback: {
            onClick: zTreeOnClick
        }
//        callback: {
//            onCheck: onCheck
//        }

    };
    var zNodes = [
        {id: 1, pId: 0, name: "随意勾选 1", open: false,click: "test(222)"},
        {id: 11, pId: 1, name: "随意勾选 1-1", open: true},
        {id: 111, pId: 11, name: "随意勾选 1-1-1"},
        {id: 112, pId: 11, name: "随意勾选 1-1-2"},
        {id: 12, pId: 1, name: "随意勾选 1-2", open: true},
        {id: 121, pId: 12, name: "随意勾选 1-2-1"},
        {id: 122, pId: 12, name: "随意勾选 1-2-2"},
        {id: 2, pId: 0, name: "随意勾选 2", open: false},
        {id: 21, pId: 2, name: "随意勾选 2-1"},
        {id: 22, pId: 2, name: "随意勾选 2-2", open: true},
        {id: 221, pId: 22, name: "随意勾选 2-2-1"},
        {id: 222, pId: 22, name: "随意勾选 2-2-2"},
        {id: 23, pId: 2, name: "随意勾选 2-13"}
    ];

    function test(temp) {
        alert(temp);
    }

    $(document).ready(function () {
        zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    });

//    function onCheck(e, treeId, treeNode) {
//        var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
//            nodes = treeObj.getCheckedNodes(true),
//            v = "";
//        for (var i = 0; i < nodes.length; i++) {
//            v += nodes[i].name + ",";
//            alert(nodes[i].id + " ;" + nodes[i].name); //获取选中节点的值
//        }
//    }

    function zTreeOnClick(event, treeId, treeNode) {
        if (!treeNode.isParent) {
            alert(treeNode.id + ", " + treeNode.name);
        }

    }


    function show() {
        $.post('http://localhost:8080/show.action', function (data) {
//            var zNodes = new Array();
//            for (var i=0;i<data.length; i++) {
//                var obj = {};
//                obj.id=data[i].id;
//                obj.pId=data[i].pid;
//                obj.name=data[i].name;
//                zNodes.push(obj);
//            }
            alert(data);
           var zTreeObj = $.fn.zTree.init($("#treeDemo2"), setting, data);
        });
    }

    function save() {

        var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = treeObj.getCheckedNodes(true),
            v = "[";
        for (var i = 0; i < nodes.length; i++) {
            v += "{'id':" + nodes[i].id + ",'pId':" + nodes[i].pId + ",'name':'" + nodes[i].name + "'},";
        }
        var str = v.substr(0,v.length-1) + "]";// 去除最后一个 ,


      /*  var json = [];
        var treeObj=$.fn.zTree.getZTreeObj("categoryTree");
        var nodes=treeObj.getCheckedNodes(true);
        for(var i = 0; i < nodes.length; i++){
            var obj = {};
            obj.dataAuthorityId = nodes[i].id;
            obj.parentId = nodes[i].pId;
            obj.name = nodes[i].name;
            obj.deep = nodes[i].deep;
            json.push(obj);
        }
        json = JSON.stringfy(json);　//要作为参数传给后台，别忘了序列化一下*/

        $.post('http://localhost:8080/save.action', {"ids": str}, function (data) {

        });
    }

</script>

</body>
</html>
