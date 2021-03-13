package me.wbf.mis.mapper;

import java.util.List;

import me.wbf.mis.entity.Sources;
import me.wbf.mis.entity.SourcesExample;
import org.apache.ibatis.annotations.Param;

public interface SourcesMapper {
    long countByExample(SourcesExample example);

    int deleteByExample(SourcesExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Sources record);

    int insertSelective(Sources record);

    List<Sources> selectByExample(SourcesExample example);

    Sources selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Sources record, @Param("example") SourcesExample example);

    int updateByExample(@Param("record") Sources record, @Param("example") SourcesExample example);

    int updateByPrimaryKeySelective(Sources record);

    int updateByPrimaryKey(Sources record);

    int deleteSourcesInRole(int sourcesId);

    List<Sources> selectSourcesByRoleId(int roleid);

    List<Sources> selectSourcesByLoginAndPid(@Param("eid") Integer eid, @Param("pid") Integer pid);
}