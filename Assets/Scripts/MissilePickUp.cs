using UnityEngine;
using UnityEngine.Events;
using static TagsAsStrings;

public class MissilePickUp : MonoBehaviour {
    public UnityEvent onPickUp = new UnityEvent();
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
        if (!other.CompareTag(playerTag)) return;
        WeaponController.missileEquipped = true;
        WeaponController.weaponType = WeaponType.Missile;
        onPickUp.Invoke();
        gameObject.SetActive(false);
    }
}