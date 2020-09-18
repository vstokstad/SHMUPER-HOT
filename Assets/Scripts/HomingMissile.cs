using UnityEngine;
using static WeaponManager;

public class HomingMissile : MonoBehaviour, IWeapon {
    private GameObject _missile;
    private Vector3 _moveDirection;
    private PlayerController _playerController;
    private float _rateOfFire = 0.5f;

    private void Awake(){
        _playerController = GetComponent<PlayerController>();
    }


    public void Shoot(){
        _missile = WeaponPool.Instance.Get(WeaponType.HomingMissile);
        Transform transform1 = _playerController.transform;
        _missile.transform.rotation = transform1.rotation;
        _missile.transform.position = transform1.position;
        _missile.gameObject.SetActive(true);
    }

    private void RateOfFire(){
        _rateOfFire -= Time.deltaTime;
        if (_rateOfFire <= 0f) { }
    }

    private void SearchForEnemy(){
        RaycastHit hitInfo;
        Ray ray = new Ray(transform.position, Vector3.right);
        Physics.SphereCast(ray, 10f, maxDistance: 10f, hitInfo: out hitInfo);
        if (!hitInfo.collider.CompareTag("Enemy")) return;
    }
}