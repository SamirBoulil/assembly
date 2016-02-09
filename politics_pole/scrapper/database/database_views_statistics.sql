-- View: deputy_statistics

-- DROP VIEW deputy_statistics;

CREATE OR REPLACE VIEW deputy_statistics AS
 SELECT general.id,
    general.name,
    general.surname,
    general.slug,
    general.party_id,
    general.stat_vote_count,
    (no_votes.stat_no_vote_count * 100)::double precision / general.stat_vote_count::double precision AS stat_no_vote,
    general.stat_participation
   FROM ( SELECT DISTINCT dep.id,
            dep.name,
            dep.surname,
            dep.slug,
            dep.party_id,
            count(v.*) AS stat_vote_count,
            (count(v.*) * 100)::double precision / (( SELECT count(*) AS count
                   FROM "Decree" dec_1))::double precision AS stat_participation
           FROM "Deputy" dep
             JOIN "Vote" v ON dep.id = v.deputy_id
             JOIN "Decree" "dec" ON v.decree_id = "dec".id
           WHERE "dec".is_solemn=true
          GROUP BY dep.id
          ORDER BY count(v.*) DESC) general
     JOIN ( SELECT dep.id,
            count(*) AS stat_no_vote_count
           FROM "Deputy" dep
             JOIN "Vote" v ON dep.id = v.deputy_id
             JOIN "Decree" "dec" ON v.decree_id = "dec".id
          WHERE v.vote_value = 0
          GROUP BY dep.id) no_votes ON general.id = no_votes.id;

ALTER TABLE deputy_statistics
  OWNER TO "Samir";

-- View: deputy_statistics

-- DROP VIEW deputy_statistics;

CREATE OR REPLACE VIEW deputy_statistics AS
 SELECT general.id,
    general.name,
    general.surname,
    general.slug,
    general.party_id,
    general.stat_vote_count,
    (no_votes.stat_no_vote_count * 100)::double precision / general.stat_vote_count::double precision AS stat_no_vote,
    general.stat_participation
   FROM ( SELECT DISTINCT dep.id,
            dep.name,
            dep.surname,
            dep.slug,
            dep.party_id,
            count(v.*) AS stat_vote_count,
            (count(v.*) * 100)::double precision / (( SELECT count(*) AS count
                   FROM "Decree" dec_1))::double precision AS stat_participation
           FROM "Deputy" dep
             JOIN "Vote" v ON dep.id = v.deputy_id
             JOIN "Decree" "dec" ON v.decree_id = "dec".id
          GROUP BY dep.id
          ORDER BY count(v.*) DESC) general
     JOIN ( SELECT dep.id,
            count(*) AS stat_no_vote_count
           FROM "Deputy" dep
             JOIN "Vote" v ON dep.id = v.deputy_id
             JOIN "Decree" "dec" ON v.decree_id = "dec".id
          WHERE v.vote_value = 0
          GROUP BY dep.id) no_votes ON general.id = no_votes.id;

ALTER TABLE deputy_statistics
  OWNER TO "Samir";
