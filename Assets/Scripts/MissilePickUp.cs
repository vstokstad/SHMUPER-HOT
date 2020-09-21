using UnityEngine;

public class MissilePickUp : MonoBehaviour {
    private Collider _collider;
    private Vector3 translateTargetPos;

    private void Awake(){
        translateTargetPos = new Vector3(-30f, Mathf.Tan(Mathf.PI));
    }

    private void FixedUpdate(){
        translateTargetPos.y = Mathf.Tan(Mathf.PI * Time.fixedDeltaTime);
        transform.Translate(translateTargetPos);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag("Player")) return;
        WeaponController.missileEquipped = true;
        WeaponController.weaponType = WeaponType.Missile;
        gameObject.SetActive(false);
    }
}