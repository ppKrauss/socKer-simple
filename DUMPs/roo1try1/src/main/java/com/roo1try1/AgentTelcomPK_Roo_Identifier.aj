// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.roo1try1;

import com.roo1try1.AgentTelcomPK;
import javax.persistence.Column;
import javax.persistence.Embeddable;

privileged aspect AgentTelcomPK_Roo_Identifier {
    
    declare @type: AgentTelcomPK: @Embeddable;
    
    @Column(name = "agid", columnDefinition = "int8", nullable = false)
    private Long AgentTelcomPK.agid;
    
    @Column(name = "id_telcom", columnDefinition = "int8", nullable = false)
    private Long AgentTelcomPK.idTelcom;
    
    @Column(name = "ismain", columnDefinition = "bool", nullable = false)
    private Boolean AgentTelcomPK.ismain;
    
    @Column(name = "isowner", columnDefinition = "bool", nullable = false)
    private Boolean AgentTelcomPK.isowner;
    
    @Column(name = "rule", columnDefinition = "int4", nullable = false)
    private Integer AgentTelcomPK.rule;
    
    public AgentTelcomPK.new(Long agid, Long idTelcom, Boolean ismain, Boolean isowner, Integer rule) {
        super();
        this.agid = agid;
        this.idTelcom = idTelcom;
        this.ismain = ismain;
        this.isowner = isowner;
        this.rule = rule;
    }

    private AgentTelcomPK.new() {
        super();
    }

    public Long AgentTelcomPK.getAgid() {
        return agid;
    }
    
    public Long AgentTelcomPK.getIdTelcom() {
        return idTelcom;
    }
    
    public Boolean AgentTelcomPK.getIsmain() {
        return ismain;
    }
    
    public Boolean AgentTelcomPK.getIsowner() {
        return isowner;
    }
    
    public Integer AgentTelcomPK.getRule() {
        return rule;
    }
    
}
