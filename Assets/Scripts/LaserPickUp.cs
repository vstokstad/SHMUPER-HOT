using UnityEngine;

public class LaserPickUp : MonoBehaviour {
    private Collider _collider;
    private Vector3 _translateTargetPos;

    private void Awake(){
        _translateTargetPos = Vector3.left;
    }

    private void FixedUpdate(){
        _translateTargetPos.y = Mathf.Sin(Mathf.PI * Time.fixedDeltaTime);
        transform.position = Vector3.Lerp(transform.position, _translateTargetPos, Time.fixedDeltaTime);
    }
    

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag("Player")) return;
        WeaponController.laserEquipped = true;
        WeaponController.weaponType = WeaponType.Laser;
        gameObject.SetActive(false);
    }
}