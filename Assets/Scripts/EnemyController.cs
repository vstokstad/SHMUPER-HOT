using System;
using UnityEngine;

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

    private void Update(){
        Vector3 direction = _playerTransform.position - transform.position;
        _rigidBody.rotation = Quaternion.Euler(direction.x, direction.y, 0f);
        direction.Normalize();
        _direction = direction;
    }

    private void FixedUpdate(){
        Move(_direction);
    }

    private void OnEnable(){
        _rigidBody = GetComponent<Rigidbody>();
        _playerTransform = GameObject.FindWithTag("Player").GetComponent<Transform>();
    }


    public void TakeDamage(float damage){
        _health -= damage;
        if (_health <= 0f) Explode();
    }


    private void Move(Vector3 direction){
        float speedAdjust = Vector3.Distance(transform.position, _playerTransform.position);
        if (_level < 2f) {
            direction.y = Mathf.Sin(Mathf.PI + speedAdjust * Time.fixedDeltaTime);
        }

        _rigidBody.AddForce(direction * (_moveSpeed * Time.fixedDeltaTime), ForceMode.Acceleration);
    }


    private void Explode(){
        _explosion = Instantiate(Resources.Load<GameObject>("Explosion")).GetComponent<ParticleSystem>();
        _explosion.transform.position = transform.position;
        _playerTransform.GetComponent<PlayerController>().killCounter += 1f;
        Destroy(gameObject);
    }
}