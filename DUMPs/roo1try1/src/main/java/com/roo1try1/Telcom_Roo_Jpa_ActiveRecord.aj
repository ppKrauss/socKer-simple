// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.roo1try1;

import com.roo1try1.Telcom;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Telcom_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Telcom.entityManager;
    
    public static final List<String> Telcom.fieldNames4OrderClauseFilter = java.util.Arrays.asList("");
    
    public static final EntityManager Telcom.entityManager() {
        EntityManager em = new Telcom().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Telcom.countTelcoms() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Telcom o", Long.class).getSingleResult();
    }
    
    public static List<Telcom> Telcom.findAllTelcoms() {
        return entityManager().createQuery("SELECT o FROM Telcom o", Telcom.class).getResultList();
    }
    
    public static List<Telcom> Telcom.findAllTelcoms(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM Telcom o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, Telcom.class).getResultList();
    }
    
    public static Telcom Telcom.findTelcom(Long id) {
        if (id == null) return null;
        return entityManager().find(Telcom.class, id);
    }
    
    public static List<Telcom> Telcom.findTelcomEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Telcom o", Telcom.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<Telcom> Telcom.findTelcomEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM Telcom o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, Telcom.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Telcom.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Telcom.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Telcom attached = Telcom.findTelcom(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Telcom.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Telcom.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Telcom Telcom.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Telcom merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
