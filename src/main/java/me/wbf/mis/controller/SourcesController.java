package me.wbf.mis.controller;

import me.wbf.mis.entity.Sources;
import me.wbf.mis.service.SourcesService;
import me.wbf.mis.util.OAResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sources")
public class SourcesController {

    @Autowired
    private SourcesService sourcesService;

    @RequestMapping("/superSources")
    @ResponseBody
    public List<Sources> getSuperSources() {
        List<Sources> sourcesList = sourcesService.findSourcesByPid0Or1();
        return sourcesList;
    }

    @RequestMapping("/add")
    @ResponseBody
    public OAResult addSources(Sources sources) {
        return sourcesService.addSources(sources);
    }

    @RequestMapping("/ztreeSources")
    @ResponseBody
    public Sources findSourcesByPid(Sources sources) {
        List<Sources> sourcesList = sourcesService.findSourcesByPid(0);
        return sourcesList.get(0);
    }

    @RequestMapping("/toEdit")
    @ResponseBody
    public Sources toEdit(int id) {
        return sourcesService.findSourcesById(id);
    }

    @RequestMapping("/edit")
    @ResponseBody
    public OAResult editSources(Sources sources) {
        return sourcesService.editSourcesById(sources);
    }

    @RequestMapping("/del")
    @ResponseBody
    public OAResult deleteSources(int sourcesId) {
        return sourcesService.deleteSourcesById(sourcesId);
    }

    @RequestMapping("/loginSources")
    @ResponseBody
    public Sources loginSources(HttpSession session) {
        List<Sources> sourcesList = sourcesService.findSourcesByLogin(session, 0);
        return sourcesList.get(0);
    }
}