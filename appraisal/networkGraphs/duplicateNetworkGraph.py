import psycopg2
import networkx as nx
from sshtunnel import SSHTunnelForwarder
import matplotlib



server = SSHTunnelForwarder(
    ('10.0.1.139', 22),
    ssh_username='bcadmin',
    ssh_pkey='/Users/mkf26/.ssh/id_ed25519',
    ssh_private_key_password='Poltergeist96!',
    remote_bind_address=('localhost', 5432)
)

server.start()

print(server.local_bind_port)  # show assigned local port
# work with `SECRET SERVICE` through `server.local_bind_port`.

conn = psycopg2.connect(
    database='digital_appraisal_new',
    user='bcadmin',
    host=server.local_bind_host,
    port=server.local_bind_port,
    password='090696')
cur = conn.cursor()

#getting duplicate relationships from database
def getRelationships():
    cur.execute("""
    with DUPES as (
    SELECT
        f1.id AS file_id,
        f1.directory_id,
        f1.file_path,
        f1.file_name,
        f1.md5_hash,
        f1.digital_media_id,
        f1.format_id,
        f1.file_type,
        f1.size,
        f2.id AS duplicate_file_id,
        f2.file_name as duplicate_name,
        f2.file_path as duplicate_file_path,
        f2.digital_media_id as duplicate_media_id
    FROM
        files f1
    JOIN
        files f2
    ON
        f1.md5_hash = f2.md5_hash
    WHERE
        f1.digital_media_id != f2.digital_media_id
        AND f1.id != f2.id
        and f1.appraisal_decision is NULL
        and f2.appraisal_decision is NULL
    )
    
    select digital_media_id, duplicate_media_id,
    count(distinct file_id) as unique_duplicate_file_count
    from DUPES
    join media
    on digital_media_id = media.id
    where group_id = '1.1'
    group by digital_media_id, duplicate_media_id
    order by unique_duplicate_file_count desc;""")
    relationships = cur.fetchall()
    return relationships

# getting nodes from relationships (list of tuples created by above function)
def getNodes(relationships):
    #gets full list of media IDs and file counts from the DB
    cur.execute("""select id, file_count from 
    (select m.id, count(*) as file_count
    from media as m
    left join files as f
    on m.id = f.digital_media_id
    group by m.id
    order by m.id)
    where file_count != 1;""")
    media_ids_counts = cur.fetchall()
    #condenses digital_media_ids from a list of tuples (relationsips) into unique list to compare against
    relevant_media_ids = list(set([media_id for tup in relationships for media_id in tup[:2]]))
    #create list of nodes by comparing against the list of relevant media ids
    nodes = [f"{item[0]} ({item[1]} total files)" for item in media_ids_counts if item[0] in relevant_media_ids]
    return nodes

def getEdges(relationships):
    edges = [(relation[0], relation[1]) for relation in relationships if relation[2] > 1000]
    return edges

relationships = getRelationships()
nodes = getNodes(relationships)
edges = getEdges(relationships)

G = nx.Graph()

G.add_nodes_from(nodes)
G.add_edges_from(edges)

nx.draw(G, with_labels = True)




cur.close()
conn.close()
server.stop()