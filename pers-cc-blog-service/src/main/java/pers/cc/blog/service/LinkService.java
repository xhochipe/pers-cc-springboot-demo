package pers.cc.blog.service;

import java.util.List;
import java.util.Map;

import pers.cc.blog.model.Link;

/**
 * 友情链接Service接口
 * 
 * @author Administrator
 *
 */
public interface LinkService {

    /**
     * 查询友情链接信息
     * 
     * @param map
     * @return
     */
    public List<Link> list(Map<String, Object> map);

    /**
     * 获取总记录数
     * 
     * @param map
     * @return
     */
    public Long getTotal(Map<String, Object> map);

    /**
     * 添加友情链接
     * 
     * @param link
     * @return
     */
    public Integer add(Link link);

    /**
     * 更新友情链接
     * 
     * @param link
     * @return
     */
    public Integer update(Link link);

    /**
     * 删除友情链接
     * 
     * @param id
     * @return
     */
    public Integer delete(Integer id);

}
