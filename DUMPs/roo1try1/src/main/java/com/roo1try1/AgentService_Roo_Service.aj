// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.roo1try1;

import com.roo1try1.Agent;
import com.roo1try1.AgentService;
import java.util.List;

privileged aspect AgentService_Roo_Service {
    
    public abstract long AgentService.countAllAgents();    
    public abstract void AgentService.deleteAgent(Agent agent);    
    public abstract Agent AgentService.findAgent(Long id);    
    public abstract List<Agent> AgentService.findAllAgents();    
    public abstract List<Agent> AgentService.findAgentEntries(int firstResult, int maxResults);    
    public abstract void AgentService.saveAgent(Agent agent);    
    public abstract Agent AgentService.updateAgent(Agent agent);    
}
