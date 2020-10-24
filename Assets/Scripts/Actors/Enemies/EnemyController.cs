using System;
using Actors.Player;
using UnityEngine;
using static Managers.TagsAsStrings;
using Random = UnityEngine.Random;

namespace Actors.Enemies {
    public class EnemyController : MonoBehaviour {
        [SerializeField] private EnemyData enemyData;
        private Vector3 _direction;
        private ParticleSystem _explosion;
        private float _health;
        private float _level;
        private float _moveSpeed;
        private Transform _playerTransform;
        private Rigidbody _rigidBody;
        [NonSerialized] public float crashDamage;

        private void Awake(){
            _health = enemyData.health;
            _moveSpeed = enemyData.moveSpeed;
            crashDamage = enemyData.crashDamage;
            _level = enemyData.enemyLevel;
        }

        private void FixedUpdate(){
            Vector3 direction = _playerTransform.position - transform.position;
            _direction = direction;
            _rigidBody.rotation = Quaternion.Euler(_direction.x, _direction.y, 0f);
            _direction.Normalize();
            Move(_direction);
        }

        private void OnEnable(){
            _rigidBody = GetComponent<Rigidbody>();
            _playerTransform = GameObject.FindWithTag(playerTag).GetComponent<Transform>();
        }


        public void TakeDamage(float damage){
            _health -= damage;
            if (_health <= 0f) Explode();
        }


        private void Move(Vector3 direction){
            float speedAdjust = Vector3.Distance(_playerTransform.position, transform.position);

            if (_level < 2f) {speedAdjust = 3f;
                direction.y = Mathf.Sin(direction.y * (Mathf.PI * Time.fixedDeltaTime));}

            if (_level >= 3) {
                speedAdjust = 10f; }
            
            _rigidBody.AddForce(direction * (speedAdjust + _moveSpeed * Time.fixedDeltaTime), ForceMode.Acceleration);
        }


        private void Explode(){
            _explosion = Instantiate(Resources.Load<GameObject>(explosionTag)).GetComponent<ParticleSystem>();
            _explosion.transform.position = transform.position;
            _playerTransform.GetComponent<PlayerController>().killCounter += 1f;
            Destroy(gameObject);
        }
    }
}