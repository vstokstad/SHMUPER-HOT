using System;
using UnityEngine;
using Random = UnityEngine.Random;

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
        _rigidBody = GetComponent<Rigidbody>();
        _playerTransform = GameObject.FindWithTag("Player").GetComponent<Transform>();
        _explosion = Instantiate(Resources.Load<GameObject>("Explosion"), transform).GetComponent<ParticleSystem>();
    }

    private void Update(){
        Vector3 direction = _playerTransform.position - transform.position;
        if (_level > 2f)
            if (Level3Evasion())
                direction = transform.position + _playerTransform.position;

        _rigidBody.rotation = Quaternion.Euler(direction.x, direction.y, 0f);
        direction.Normalize();
        _direction = direction;
    }

    private void FixedUpdate(){
        Move(_direction);
    }


    public void TakeDamage(float damage){
        if (_level > 1f) _rigidBody.AddForce(-_direction * _moveSpeed, ForceMode.Impulse);

        _health = -damage;
        if (_health <= 0f) Explode();
    }


    private void Move(Vector3 direction){
        float speedAdjust = Vector3.Distance(transform.position, _playerTransform.position);
        if (_level < 2f)
            direction.y *= Mathf.Sin(Mathf.PI * Random.Range(1f, 5f) * Time.fixedDeltaTime);
        else if (_level >= 2f) speedAdjust *= _level;

        if (_level > 2f) direction = speedAdjust * direction;

        _rigidBody.AddForce(direction * (speedAdjust + _moveSpeed * Time.fixedDeltaTime), ForceMode.Acceleration);
    }

    private bool Level3Evasion(){
        var raycastHits = new RaycastHit[20];
        Ray ray = new Ray(transform.position, _playerTransform.position);
        Physics.RaycastNonAlloc(ray, raycastHits, 40f, 8, QueryTriggerInteraction.Collide);
        foreach (RaycastHit hit in raycastHits)
            if (hit.transform.gameObject.CompareTag("Shot"))
                return true;

        return false;
    }

    private void Explode(){
        _explosion.transform.position = transform.position;
        _explosion.Play();
        _rigidBody.velocity = Vector3.zero;
        _moveSpeed = 0f;
        _playerTransform.GetComponent<PlayerController>().killCounter += 1f;
      //  Destroy(_explosion.gameObject, _explosion.main.duration);
        Destroy(gameObject, _explosion.main.duration);
    }
}