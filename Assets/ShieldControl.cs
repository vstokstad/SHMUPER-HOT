
using System;
using UnityEngine;

public class ShieldControl : MonoBehaviour {
    private const float _shieldDamage = 0.5f;
    private float _shieldHealth = 1f;

     AsyncOperation explosion = new AsyncOperation {
        //TODO GEt explosion to trigger before disabeling.
    };

    private void Awake(){
        
    }

    private void OnTriggerEnter(Collider other){
        Debug.Log("Collision with" + other.gameObject.tag);
        if (other.CompareTag("Player")) return;
        if (other.CompareTag("Shot")) return;
       
        if (other.CompareTag("Enemy")) {
            other.attachedRigidbody.AddExplosionForce(50f, transform.position, 5f);
            EnemyController enemyController = other.gameObject.GetComponent<EnemyController>();
            enemyController.TakeDamage(_shieldDamage);
            TakeDamage(enemyController.enemyData.crashDamage);
            if (_shieldHealth <= 0f && gameObject.activeSelf) {
                _shieldHealth = 1f;
                gameObject.SetActive(false);
            }
        }


    }

    public void TakeDamage(float damage){
        _shieldHealth -= damage;
       
    }
   
}
