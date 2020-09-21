using UnityEngine;

public class LaserPickUp : MonoBehaviour {
    private Collider _collider;
    private Vector3 _translateTargetPos;

    private void Awake(){
        _translateTargetPos = new Vector3(-30f, Mathf.Tan(Mathf.PI));
    }

    private void FixedUpdate(){
        _translateTargetPos.y = Mathf.Tan(Mathf.PI * Time.fixedDeltaTime);
        transform.Translate(_translateTargetPos);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag("Player")) return;
        WeaponController.laserEquipped = true;
        WeaponController.weaponType = WeaponType.Laser;
        gameObject.SetActive(false);
    }
}