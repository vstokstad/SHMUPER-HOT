using UnityEngine;
using static TagsAsStrings;
using static WeaponManager;


public class PlasmaShot : MonoBehaviour, IWeapon {
    private PlayerController _playerController;
    private float _shootTimer = 0.3f;

    private void Awake(){
        _playerController = GameObject.FindWithTag(playerTag).GetComponent<PlayerController>();
    }


    public void Shoot(){
        if (!(_shootTimer <= 0f)) {
            _shootTimer -= Time.deltaTime;
            return;
        }

        if (!(PlayerData.boostCharge >= 0.5f)) return;
        _shootTimer = 0.3f;

        PlayerData.boostCharge -= 0.5f;
        Vector3 plasmaVelocity = new Vector3(20f, 0f);
        GameObject plasmaShot = WeaponPool.Instance.Get(WeaponType.Plasma);
        Vector3 initialPosition = _playerController.gameObject.transform.position;
        initialPosition.x += 1f;
        plasmaShot.transform.position = initialPosition;
        plasmaShot.SetActive(true);
        plasmaVelocity.x = 20f;
        plasmaVelocity.y = 0f;
        plasmaShot.GetComponent<Rigidbody>().velocity = plasmaVelocity;
    }
}