package com.qf.oa.realm;

import com.qf.oa.entity.Employee;
import com.qf.oa.entity.Resc;
import com.qf.oa.service.IEmpService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class MyRealm extends AuthorizingRealm {
    @Autowired
    private IEmpService empService;
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        Employee employee = (Employee) principalCollection.getPrimaryPrincipal();
        List<Resc> rescs = employee.getRescs();
        if(rescs!=null){
            SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
            for (Resc resc:rescs) {
                if(resc.getRpath() != null && !"".equals(resc.getRpath())) {
                    simpleAuthorizationInfo.addStringPermission(resc.getRpath());
                }
            }
        }
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //获取登录的邮箱名称
        String email = (String) authenticationToken.getPrincipal();
        //通过邮箱信息查询到用户信息和权限
        Employee employee =  empService.queryByEmail(email);
        System.out.println(employee);
        //验证登录信心
        if(employee!=null){
            SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(employee,employee.getPassword(),this.getName());
            return simpleAuthenticationInfo;
        }
        return null;
    }
}
