package me.wbf.mis.service;

import me.wbf.mis.entity.Sources;
import me.wbf.mis.util.OAResult;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface SourcesService {
    List<Sources> findSourcesByPid0Or1();

    OAResult addSources(Sources sources);

    List<Sources> findSourcesByPid(int i);

    Sources findSourcesById(int id);

    OAResult editSourcesById(Sources sources);

    OAResult deleteSourcesById(int sourcesId);

    List<Sources> findSourcesByLogin(HttpSession session,Integer pid);
}
