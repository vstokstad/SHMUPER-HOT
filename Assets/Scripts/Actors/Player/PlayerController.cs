using System.Collections;
using System.Collections.Generic;
using Actors.Enemies;
using Managers;
using UnityEngine;
using UnityEngine.Events;
using static Managers.TagsAsStrings;

namespace Actors.Player {
    [RequireComponent(typeof(PlayerInput), typeof(PlayerMovement), typeof(PlayerBoundaries))]
    [RequireComponent(typeof(Rigidbody))]
    [RequireComponent(typeof(SphereCollider), typeof(ParticleSystem))]
    public class PlayerController : MonoBehaviour {
        [SerializeField] public PlayerData playerData;
        public float killCounter;
        public WeaponPickUpManager weaponPickUpManager;
        public UnityEvent gameOverEvent = new UnityEvent();
        private Rigidbody _playerRigidbody;
        private Renderer _renderer;

        private void Awake(){
            killCounter = 0f;
            _playerRigidbody = GetComponent<Rigidbody>();
            _renderer = GetComponent<Renderer>();
        }

        public void BatchUpdate(){
            playerData.RechargeTimer();
            if (killCounter > 5f && killCounter < 10f)
                weaponPickUpManager.SpawnLaser();
            else if (killCounter > 10f && killCounter < 15f) weaponPickUpManager.SpawnMissiles();

            if (killCounter >= playerData.highScore) playerData.highScore = killCounter;
        }

        private void OnCollisionEnter(Collision other){
            if (!other.collider.CompareTag(enemyTag)) return;
            CollisionManager(other);
        }

        private void CollisionManager(Collision other){
            EnemyController enemyController = other.gameObject.GetComponent<EnemyController>();
            Rigidbody enemyBody = other.gameObject.GetComponent<Rigidbody>();
            Vector3 velocity = _playerRigidbody.velocity * 2f;
            StartCoroutine(TakeDamage(PlayerData.health, enemyController.crashDamage));
            enemyBody.AddRelativeForce(velocity.x, velocity.y, 0f, ForceMode.VelocityChange);
            
        }


        private IEnumerator TakeDamage(float playerHealth, float damage){
            playerHealth -= damage;
            PlayerData.health = playerHealth;
            Color color = _renderer.material.color;
            _renderer.material.color = Color.red;
            Handheld.Vibrate();
           yield return new WaitForFixedUpdate();
            _renderer.material.color = color;
            if (PlayerData.health <= 0f) gameOverEvent.Invoke();
        }
    }
}