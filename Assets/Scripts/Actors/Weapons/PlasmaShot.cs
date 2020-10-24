using Actors.Player;
using UnityEngine;
using static Managers.TagsAsStrings;
using static Managers.WeaponManager;


namespace Actors.Weapons {
    public class PlasmaShot : MonoBehaviour, IWeapon {
       [SerializeField] private PlayerController _playerController;

        [SerializeField] private float timeBetweenShots = 0.0f;
        private float _shootTimer;

        private void Awake(){
            _playerController = GameObject.FindWithTag(playerTag).GetComponent<PlayerController>();
            _shootTimer = timeBetweenShots;
        }


        public void Shoot(){
            if (!(_shootTimer <= 0.0f)) {
                _shootTimer -= Time.unscaledDeltaTime;
                return;
            }

            if ((PlayerData.boostCharge <= 0.5f)) return;
            _shootTimer = timeBetweenShots;

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
}