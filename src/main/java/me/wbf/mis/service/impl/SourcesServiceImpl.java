package me.wbf.mis.service.impl;

import me.wbf.mis.entity.Employee;
import me.wbf.mis.entity.Sources;
import me.wbf.mis.entity.SourcesExample;
import me.wbf.mis.mapper.SourcesMapper;
import me.wbf.mis.service.SourcesService;
import me.wbf.mis.util.OAResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class SourcesServiceImpl implements SourcesService {

    @Autowired
    private SourcesMapper sourcesMapper;

    @Override
    public List<Sources> findSourcesByPid0Or1() {
        SourcesExample sourcesExample = new SourcesExample();
        SourcesExample.Criteria criteria = sourcesExample.createCriteria();
        criteria.andPidLessThan(2);
        return sourcesMapper.selectByExample(sourcesExample);
    }

    @Override
    public OAResult addSources(Sources sources) {
        try {
            int i = sourcesMapper.insertSelective(sources);
            return OAResult.build(200, "添加成功!");
        } catch (Exception e) {
            return OAResult.build(400, "资源添加失败！原因：" + e.getMessage());
        }
    }

    @Override
    public List<Sources> findSourcesByPid(int pid) {
        SourcesExample sourcesExample = new SourcesExample();
        SourcesExample.Criteria criteria = sourcesExample.createCriteria();
        criteria.andPidEqualTo(pid);
        List<Sources> sourcesList = sourcesMapper.selectByExample(sourcesExample);
        for (Sources sources : sourcesList) {
            if (sources.getPid() < 2) {
                sources.setOpen(true);
            }
            sources.setUrl(null);
            List<Sources> sourcesByPid = findSourcesByPid(sources.getId());
            sources.setChildren(sourcesByPid);
        }
        return sourcesList;
    }

    @Override
    public Sources findSourcesById(int id) {
        return sourcesMapper.selectByPrimaryKey(id);
    }

    @Override
    public OAResult editSourcesById(Sources sources) {
        try {
            int i = sourcesMapper.updateByPrimaryKeySelective(sources);
            return OAResult.build(200, "资源修改成功!");
        } catch (Exception e) {
            return OAResult.build(400, "资源修改失败，原因：" + e.getMessage());
        }
    }

    @Override
    public OAResult deleteSourcesById(int sourcesId) {
        try {
            sourcesMapper.deleteSourcesInRole(sourcesId);
            sourcesMapper.deleteByPrimaryKey(sourcesId);
            return OAResult.build(200, "资源删除成功!");
        } catch (Exception e) {
            return OAResult.build(400, "资源删除失败，原因：" + e.getMessage());
        }
    }

    @Override
    public List<Sources> findSourcesByLogin(HttpSession session, Integer pid) {
        Employee employee = (Employee) session.getAttribute("login");
        List<Sources> sourcesList = sourcesMapper.selectSourcesByLoginAndPid(employee.getEid(), pid);
        for (Sources sources : sourcesList) {
            List<Sources> list = findSourcesByLogin(session, sources.getId());
            sources.setChildren(list);
        }
        return sourcesList;
    }
}
