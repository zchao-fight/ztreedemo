package cn.ccf.controller;

import cn.ccf.mapper.MenuMapper;
import cn.ccf.mapper.PermissionMapper;
import cn.ccf.pojo.Menu;
import cn.ccf.pojo.MenuExample;
import cn.ccf.pojo.Permission;
import cn.ccf.pojo.PermissionExample;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class demoController {

    @Autowired
    private PermissionMapper permissionMapper;
    @Autowired
    private MenuMapper menuMapper;

    @RequestMapping("/index")
    public String demo() {
        return "index";
    }

    @RequestMapping("/show")
    @ResponseBody
    public JSONArray show(HttpServletRequest request) {
        PermissionExample permissionExample = new PermissionExample();
        List<Permission> listPermission = permissionMapper.selectByExample(permissionExample);
        MenuExample menuExample = new MenuExample();
        List<Menu> listMenu = menuMapper.selectByExample(menuExample);

        List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < listMenu.size(); i++) {
            Menu menu = listMenu.get(i);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", menu.getId());
            map.put("pId", menu.getPid());
            map.put("name", menu.getName());
            for (Permission permission : listPermission) {
                if (menu.getId() == permission.getId()) {
                    map.put("checked", true);
                }
            }
            mapList.add(map);
        }

        JSONArray jsonArray = JSON.parseArray(JSON.toJSONString(mapList));
        return jsonArray;
    }


    @RequestMapping("/save")
    @ResponseBody
    public JSONObject save(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        String ids = request.getParameter("ids");
        JSONArray jsonArray = JSONArray.parseArray(ids);

        Permission permission = new Permission();

        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject jsonObject1 = (JSONObject) jsonArray.get(i);
            Integer id = jsonObject1.getInteger("id");
            Integer Pid = jsonObject1.getInteger("pId");
            String name = jsonObject1.getString("name");
            permission.setId(id);
            permission.setPid(Pid);
            permission.setName(name);
            permissionMapper.insertSelective(permission);
        }
        return jsonObject;

    }


}
