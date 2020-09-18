using System;
using UnityEngine;

public class LaserBeamControl : MonoBehaviour {
  public float laserDamage = 0.5f;
  

   private void OnTriggerEnter(Collider other){
      if (!other.gameObject.CompareTag("Enemy")) return;
      other.GetComponent<EnemyController>().TakeDamage(laserDamage);
   }

   private void OnTriggerExit(Collider other){
      if (!other.gameObject.CompareTag("Enemy")) return;
      other.GetComponent<EnemyController>().TakeDamage(laserDamage);
   }

   private void OnTriggerStay(Collider other){
      if (!other.gameObject.CompareTag("Enemy")) return;
      other.GetComponent<EnemyController>().TakeDamage(laserDamage);
   }
}
