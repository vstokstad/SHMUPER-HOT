using UnityEngine;
using static WeaponManager;


public class PlasmaShot : MonoBehaviour, IWeapon {
    private PlayerController _playerController;
    private float _shootTimer = 0.3f;

    private void Awake(){
        _playerController = GameObject.FindWithTag("Player").GetComponent<PlayerController>();
    }


    public void Shoot(){
        if (!(_shootTimer <= 0f)) {
            _shootTimer -= Time.deltaTime;
            return;
        }

        _shootTimer = 0.3f;

        Vector3 plasmaVelocity = new Vector3(20f, 0f);
        GameObject _plasmaShot;
        _plasmaShot = WeaponPool.Instance.Get(WeaponType.Plasma);
        Vector3 initialPosition = _playerController.gameObject.transform.position;
        initialPosition.x += 1f;
        _plasmaShot.transform.position = initialPosition;
        _plasmaShot.SetActive(true);
        plasmaVelocity.x = 20f;

        plasmaVelocity.y = Mathf.Tan(initialPosition.y * Time.fixedUnscaledDeltaTime);
        _plasmaShot.GetComponent<Rigidbody>().velocity = plasmaVelocity;
    }
}