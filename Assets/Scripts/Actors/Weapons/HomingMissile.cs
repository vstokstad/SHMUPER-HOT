using Actors.Player;
using UnityEngine;
using static Managers.TagsAsStrings;
using static Managers.WeaponManager;

namespace Actors.Weapons {
    public class HomingMissile : MonoBehaviour, IWeapon {
        private GameObject _player;
        [SerializeField] private float rateOfFire = 0.2f;
        private float _fireTimer;
        public void Update(){
            _fireTimer -= Time.deltaTime;
        }


        private void OnEnable(){
            _fireTimer = rateOfFire;
            gameObject.SetActive(true);
            _player = GameObject.FindGameObjectWithTag(playerTag);
        }

        public void Shoot(){
            if (!FireTimer() || PlayerData.boostCharge <= 1f) return;
            PlayerData.boostCharge -= 1.5f;
            GameObject missile = WeaponPool.Instance.Get(WeaponType.Missile);
            Transform transform1 = _player.transform;
            missile.transform.position = transform1.position;
            missile.gameObject.SetActive(true);
        }

        private bool FireTimer(){
            if (!(_fireTimer <= 0f)) return false;
            _fireTimer = rateOfFire;
            return true;
        }
    }
}