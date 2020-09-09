using UnityEngine;

public class EnemyController : MonoBehaviour {
    [SerializeField] public EnemyData enemyData;
    

  


    public void TakeDamage(float damage){
        enemyData.health = -damage;
        if (enemyData.health <= 0f) {
            GameObject o;
            (o = gameObject).SetActive(false);
            EnemySpawn.RespawnOnDeath(enemy: o);
           
        }
    }

  
}